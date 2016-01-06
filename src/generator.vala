/* generator.vala
 *
 * Copyright (C) 2012-2013  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


//
// This code is not supposed to be good. It's just a dirty script to reduce my work.
// Feel free to decrease the code quality even more.
//


using Gee;


public class Valadoc.IndexGenerator : Valadoc.ValadocOrgDoclet {
	private LinkedList<Package> unavailable_packages = new LinkedList<Package> ();
	private HashMap<string, Package> packages_per_name = new HashMap<string, Package> ();
	private Collection<Node> sections;
	private Regex markdown_img_regex;

	private void print_stored_messages () {
		foreach (Package pkg in unavailable_packages) {
			reporter.simple_warning ("error: Package '%s' not found", pkg.name);
		}
	}

	private void register_package (Section? section, Package pkg) {
		packages_per_name.set (pkg.name, pkg);
		if (section != null) {
			section.packages.add (pkg);
		}
	}

	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] requested_packages;
	private static bool regenerate_all_packages;
	private static string output_directory;
	private static string metadata_path;
	private static string docletpath;
	private static string vapidir;
	private static string driver;
	private static bool download_images;
	private static string prefix;
	private static bool skip_existing;
	private static string girdir = "girs/gir-1.0";
	private static string target_glib;

	public IndexGenerator (ErrorReporter reporter) {
		this.reporter = new ErrorReporter ();


		try {
			string label = "([^(\\]\n)](\n[ \t]*)?)*";
			string path = "(?<img>([^(\\)|\n)])*)";
			markdown_img_regex = new Regex ("!\\[" + label + "\\][ \t]*\n?[ \t]*\\(" + path + "\\)", RegexCompileFlags.UNGREEDY | RegexCompileFlags.OPTIMIZE);
		} catch (RegexError e) {
			assert_not_reached ();
		}
	}

	private const GLib.OptionEntry[] options = {
		{ "prefix", 0, 0, OptionArg.STRING, ref prefix, "package prefix (e.g. stable, unstable", null},
		{ "all", 0, 0, OptionArg.NONE, ref regenerate_all_packages, "Regenerate documentation for all packages", null },
		{ "directory", 'o', 0, OptionArg.FILENAME, ref output_directory, "Output directory", "DIRECTORY" },
		{ "target-glib", 0, 0, OptionArg.STRING, ref target_glib, "target", "VERSION" },
		{ "driver", 'o', 0, OptionArg.FILENAME, ref driver, "Output directory", "DIRECTORY" },
		{ "download-images", 0, 0, OptionArg.NONE, ref download_images, "Downlaod images", null },
		{ "doclet", 0, 0, OptionArg.STRING, ref docletpath, "Name of an included doclet or path to custom doclet", "PLUGIN"},
		{ "vapidir", 0, 0, OptionArg.STRING, ref vapidir, "Look for package bindings in DIRECTORY", "DIRECTORY"},
		{ "skip-existing", 0, 0, OptionArg.NONE, ref skip_existing, "Skip existing packages", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, ref requested_packages, null, "FILE..." },
		{ null }
	};

	private void parse_metadata_package (Section section, MarkupReader reader, ref MarkupTokenType current_token, ref MarkupSourceLocation begin, ref MarkupSourceLocation end) {
		string start_tag = reader.name;
		Package pkg = null;

		string? ignore = reader.get_attribute ("ignore");
		if (ignore == null || ignore != "true") {
			string? maintainers = reader.get_attribute ("maintainers");
			string? name = reader.get_attribute ("name");
			string? c_docs = reader.get_attribute ("c-docs");
			string? home = reader.get_attribute ("home");
			string? deprecated_str = reader.get_attribute ("deprecated");
			bool is_deprecated = false;
			if (deprecated_str != null && deprecated_str == "true") {
				is_deprecated = true;
			}


			if (name == null) {
				reporter.simple_error ("error: %s: Missing attribute: name=\"\"", start_tag);
				return ;
			}

			if (start_tag == "external-package") {
				string? external_link = reader.get_attribute ("link");;
				string? devhelp_link = reader.get_attribute ("devhelp");
				if (external_link == null) {
					reporter.simple_error ("error: %s: Missing attribute: link=\"\" in %s", start_tag, name);
					return ;
				} else {
					pkg = new ExternalPackage (name, external_link, maintainers, devhelp_link, home, c_docs, is_deprecated);
					register_package (section, pkg);
				}
			} else {
				string? gallery = reader.get_attribute ("gallery");
				string? gir_name = reader.get_attribute ("gir");
				string? flags = reader.get_attribute ("flags");
				pkg = new Package (name, gir_name, maintainers, home, c_docs, gallery, flags, is_deprecated);
				register_package (section, pkg);
			}
		}

		current_token = reader.read_token (out begin, out end);

		if (current_token == MarkupTokenType.TEXT) {
			if (pkg != null) {
				pkg.description = Regex.split_simple ("[ |\t]*\n[ |\t]*\n[ |\t]*", reader.content.strip ());
				try {
					Regex regex = new Regex ("[\n|\t| ]+");
					for (int i = 0; i < pkg.description.length; i++) {
						string tmp = regex.replace (pkg.description[i], -1, 0, " ");
						pkg.description[i] = tmp.strip ();
					}
				} catch (Error e) {
					assert_not_reached ();
				}
			}
			current_token = reader.read_token (out begin, out end);
		}

		if (current_token != MarkupTokenType.END_ELEMENT || reader.name != start_tag) {
			reporter.simple_error ("error: Expected: </%s> (got: %s '%s')", start_tag, current_token.to_string (), reader.name);				return ;
		}

		current_token = reader.read_token (out begin, out end);
	}

	private void parse_metadata_section (Section parent_section, MarkupReader reader, ref MarkupTokenType current_token, ref MarkupSourceLocation begin, ref MarkupSourceLocation end) {
		string name = reader.get_attribute ("name");
		if (name == null) {
			reporter.simple_error ("error: Expected: <section name=\"...\"");
			return ;
		}

		Section section = new Section (name);
		parent_section.sections.add (section);

		current_token = reader.read_token (out begin, out end);

		while (current_token != MarkupTokenType.END_ELEMENT && current_token != MarkupTokenType.EOF) {
			if (current_token != MarkupTokenType.START_ELEMENT || !(reader.name == "package" || reader.name == "external-package" || reader.name == "section")) {
				reporter.simple_error ("error: Expected: <section>|<package>|<external-package> (got: %s '%s')", current_token.to_string (), reader.name);
				return ;
			}

			if (reader.name == "package" || reader.name == "external-package") {
				parse_metadata_package (section, reader, ref current_token, ref begin, ref end);
			} else if (reader.name == "section") {
				parse_metadata_section (section, reader, ref current_token, ref begin, ref end);
			} else {
				assert_not_reached ();
			}
		}

		if (current_token != MarkupTokenType.END_ELEMENT || reader.name != "section") {
			reporter.simple_error ("error: Expected: </section> (got: %s '%s')", current_token.to_string (), reader.name);
			return ;
		}

		current_token = reader.read_token (out begin, out end);
	}

	private void load_metadata (string filename) {
		MarkupReader reader = new MarkupReader (filename, reporter);

		MarkupSourceLocation begin;
		MarkupSourceLocation end;

		var current_token = reader.read_token (out begin, out end);
		current_token = reader.read_token (out begin, out end);
		current_token = reader.read_token (out begin, out end);

		if (current_token != MarkupTokenType.START_ELEMENT || reader.name != "packages") {
			reporter.simple_error ("error: Expected: <packages>");
			return ;
		}

		current_token = reader.read_token (out begin, out end);

		Section section = new Section ("");

		while (current_token != MarkupTokenType.END_ELEMENT && current_token != MarkupTokenType.EOF) {
			if (current_token != MarkupTokenType.START_ELEMENT || reader.name != "section") {
				reporter.simple_error ("error: Expected: <section> (got: %s '%s')", current_token.to_string (), reader.name);
				return ;
			}

			parse_metadata_section (section, reader, ref current_token, ref begin, ref end);
		}

		this.sections = section.sections;

		if (current_token != MarkupTokenType.END_ELEMENT || reader.name != "packages") {
			reporter.simple_error ("error: Expected: </packages> (got: %s '%s')", current_token.to_string (), reader.name);
			return ;
		}
	}

	private abstract class Node {
		public abstract void render (Renderer renderer);
	}

	private class Section : Node {
		public string name;
		public Collection<Package> packages = new ArrayList<Package> ();
		public Collection<Section> sections = new ArrayList<Section> ();

		public Section (string name) {
			this.name = name;
		}

		public Collection<Package> sorted_package_list () {
			ArrayList<Package> packages = new ArrayList<Package> ();
			packages.add_all (this.packages);
			packages.sort ((a, b) => {
				return ((Package) a).name.ascii_casecmp (((Package) b).name);
			});

			return packages;
		}

		public override void render (Renderer renderer) {
			renderer.render_section (this);
		}
	}

	private class Package : Node {
		public string? devhelp_link;
		public string? maintainers;
		public string online_link;
		public string? gir_name;
		public string name;
		public string? home;
		public string? c_docs;
		public string flags;
		public bool is_deprecated;
		public string? gallery;
		public string[] description;
		public bool is_docbook = false;
		public string? sgml_path;

		public virtual string get_documentation_source () {
			StringBuilder builder = new StringBuilder ();

			if (get_gir_file () != null) {
				builder.append (".gir");
			}

			if (get_valadoc_file () != null) {
				builder.append ((builder.len == 0)? ".valadoc" : ", .valadoc");
			}

			return (builder.len == 0)? "none" : builder.str;
		}

		protected Package.dummy () {}

		public Package (string name, string? gir_name = null, string? maintainers = null, string? home = null, string? c_docs = null, string? gallery = null, string? flags = null, bool is_deprecated = false) {
			devhelp_link = "/" + name + "/" + name + ".tar.bz2";
			online_link = "/" + name + "/index.htm";
			this.is_deprecated = is_deprecated;
			this.maintainers = maintainers;
			this.gir_name = gir_name;
			this.c_docs = c_docs;
			this.name = name;
			this.home = home;
			this.flags = flags ?? "";
			this.gallery = gallery;
		}

		public void load_metadata (ErrorReporter reporter) {
			if (gir_name == null) {
				return ;
			}


			string meta_path = "documentation/%s/%s.valadoc.metadata".printf (name, gir_name);
			if (FileUtils.test (meta_path, FileTest.EXISTS)) {
				stdout.printf ("  load keyfile ...\n");

				try {
					var key_file = new KeyFile ();
					key_file.load_from_file (meta_path, KeyFileFlags.NONE);

					if (key_file.has_key ("General", "is_docbook")) {
						this.is_docbook = key_file.get_boolean ("General", "is_docbook");
					}
					if (key_file.has_key ("General", "index_sgml_online")) {
						this.sgml_path = key_file.get_string ("General", "index_sgml_online");
						if (this.sgml_path != null) {
							this.sgml_path = Path.build_path ("/", this.sgml_path, "index.sgml");
						}
					}
				} catch (Error e) {
					reporter.simple_error ("error: invalid key file: %s", e.message);
					return ;
				}
			}
		}

		public string? get_gir_file_metadata_path () {
			string path = Path.build_path (Path.DIR_SEPARATOR_S, "documentation", name, gir_name + ".valadoc.metadata");
			if (FileUtils.test (path, FileTest.IS_REGULAR)) {
				return Path.get_dirname (path);
			}

			return null;
		}

		public virtual string? get_gir_file () {
			if (gir_name == null) {
				return null;
			}

			string path = Path.build_path (Path.DIR_SEPARATOR_S, "girs", "gir-1.0", gir_name + ".gir");
			if (FileUtils.test (path, FileTest.IS_REGULAR)) {
				return path;
			}

			return null;
		}

		public virtual string? get_catalog_file () {
			string path = Path.build_path (Path.DIR_SEPARATOR_S, "documentation", name, name + ".catalog");
			if (FileUtils.test (path, FileTest.IS_REGULAR)) {
				return path;
			}

			return null;
		}

		public virtual string? get_valadoc_file () {
			string path = Path.build_path (Path.DIR_SEPARATOR_S, "documentation", name, name + ".valadoc");
			if (FileUtils.test (path, FileTest.IS_REGULAR)) {
				return path;
			}

			return null;
		}

		public virtual string? get_vapi_path () {
			string path = Path.build_path (Path.DIR_SEPARATOR_S, "girs", "vala", "vapi", name + ".vapi");
			if (FileUtils.test (path, FileTest.IS_REGULAR)) {
				return path;
			}

			path = Path.build_filename (vapidir, name + ".vapi");
			if (FileUtils.test (path, FileTest.IS_REGULAR)) {
				return path;
			}

			return null;
		}

		public override void render (Renderer renderer) {
			renderer.render_package (this);
		}
	}

	private class ExternalPackage : Package {

		public ExternalPackage (string name, string online_link, string? maintainers, string? devhelp_link, string? home, string? c_docs, bool is_deprecated) {
			Package.dummy ();

			this.is_deprecated = is_deprecated;
			this.devhelp_link = devhelp_link;
			this.online_link = online_link;
			this.maintainers = maintainers;
			this.c_docs = c_docs;
			this.home = home;
			this.name = name;
		}

		public override string get_documentation_source () {
			return "unknown";
		}

		public override string? get_gir_file () {
			return null;
		}

		public override string? get_valadoc_file () {
			return null;
		}

		public override string? get_vapi_path () {
			return null;
		}

		public override string? get_catalog_file () {
			return null;
		}

		public override void render (Renderer renderer) {
			renderer.render_external_package (this);
		}
	}

	private abstract class Renderer {
		public abstract void render (string path, Collection<Node> sections);
		public abstract void render_section (Section section);
		public abstract void render_package (Package pkg);
		public abstract void render_external_package (ExternalPackage pkg);
	}

	// TODO
	public void load (string path) throws Error {
		Dir dirptr = Dir.open (path);
		string? dir;

		while ((dir = dirptr.read_name ()) != null) {
			string dir_path = Path.build_path (Path.DIR_SEPARATOR_S, path, dir);
			if (dir == ".sphinx" || dir == "scripts" || dir == "styles" || dir == "images" || dir == "templates") {
				continue;
			}

			if (FileUtils.test (dir_path, FileTest.IS_DIR)) {
				if (!packages_per_name.has_key (dir)) {
					register_package (null, new Package (dir));
				}
			}
		}
	}

	private ArrayList<Package> get_sorted_package_list () {
		ArrayList<Package> packages = new ArrayList<Package> ();
		packages.add_all (packages_per_name.values);
		packages.sort ((a, b) => {
			return ((Package) a).name.ascii_casecmp (((Package) b).name);
		});

		return packages;
	}

	private void generate_navigation (string path) {
		GLib.FileStream file = GLib.FileStream.open (path, "w");
		var writer = new Html.MarkupWriter (file);

		writer.start_tag ("div", {"class", "site_navigation"});
		writer.start_tag ("ul", {"class", "navi_main"});

		ArrayList<Package> packages = get_sorted_package_list ();
		foreach (Package pkg in packages) {
			if (pkg is ExternalPackage) {
				writer.start_tag ("li", {"class", "package"}).start_tag ("a", {"href", pkg.online_link}).text (pkg.name).end_tag ("a").simple_tag ("img", {"src", "/images/external_link.png"}).end_tag ("li");
			} else {
				writer.start_tag ("li", {"class", "package"}).start_tag ("a", {"href", pkg.online_link}).text (pkg.name).end_tag ("a").end_tag ("li");
			}
		}

		writer.end_tag ("ul");
		writer.end_tag ("div");
	}

	private class IndexRenderer : Renderer {
		private const int HEADER_LEVEL_START = 2;

		private Html.MarkupWriter writer;
		private int header_level = HEADER_LEVEL_START;


		public override void render (string path, Collection<Node> sections) {
			GLib.FileStream file = GLib.FileStream.open (path, "w");
			writer = new Html.MarkupWriter (file);

			writer.start_tag ("div", {"class", "site_content"});

			// Intro:
			writer.start_tag ("h1", {"class", "main_title"}).text ("Packages").end_tag ("h1");
			writer.simple_tag ("hr", {"class", "main_hr"});

			writer.start_tag ("h2").text ("Submitting API-Bugs and Patches").end_tag ("h2");
			writer.start_tag ("p").text ("For all bindings where the status is not marked as external, and unless otherwise noted, bugs and patches should be submitted to the bindings component in the Vala product in the GNOME Bugzilla.").end_tag ("p");

			writer.start_tag ("h2").text ("Bindings without maintainer(s) listed").end_tag ("h2");
			writer.start_tag ("p").text ("The general bindings maintainer is Evan Nemerson (IRC nickname: nemequ). If you would like to adopt some bindings, please contact him.").end_tag ("p");

			foreach (Node node in sections) {
				node.render (this);
			}

			writer.end_tag ("div");
			writer = null;
		}

		public override void render_section (Section section) {
			if (header_level == HEADER_LEVEL_START) {
				writer.simple_tag ("hr", {"class", "main_hr"});
			}

			string tag = "h%d".printf (header_level);
			writer.start_tag (tag).text (section.name).end_tag (tag);

			header_level++;

			foreach (Node node in section.sections) {
				node.render (this);
			}

			render_table_begin ();
			foreach (Package pkg in section.sorted_package_list ()) {
				pkg.render (this);
			}
			render_table_end ();

			header_level--;
		}

		public override void render_package (Package pkg) {
			render_table_entry (pkg);
		}

		public override void render_external_package (ExternalPackage pkg) {
			render_table_entry (pkg);
		}

		private void render_table_begin () {
			writer.start_tag ("table", {"style", "width: 100%; margin: auto;"});

			writer.start_tag ("tr");
			writer.start_tag ("td", {"width", "10"}).end_tag ("td");
			writer.start_tag ("td", {"width", "20"}).end_tag ("td");
			writer.start_tag ("td").end_tag ("td");
			writer.start_tag ("td", {"width", "160"}).end_tag ("td");
			writer.start_tag ("td", {"width", "100"}).end_tag ("td");
			writer.start_tag ("td", {"width", "50"}).end_tag ("td");
			writer.start_tag ("td", {"width", "110"}).end_tag ("td");
			writer.start_tag ("td", {"width", "10"}).end_tag ("td");
			writer.end_tag ("tr");
		}

		private void render_table_entry (Package pkg) {
			writer.start_tag ("tbody", {"class", "highlight"});

			//string maintainers = pkg.maintainers ?? "-";
			writer.start_tag ("tr");
			writer.start_tag ("td").end_tag ("td"); // space
			writer.start_tag ("td").simple_tag ("img", {"src", "/images/package.svg"}).end_tag ("td");

			writer.start_tag ("td");
			if (pkg.is_deprecated) {
				writer.start_tag ("s").start_tag ("a", {"href", pkg.online_link}).text (pkg.name).end_tag ("a").end_tag ("s");
			} else {
				writer.start_tag ("a", {"href", pkg.online_link}).text (pkg.name).end_tag ("a");
			}

			if (pkg is ExternalPackage) {
				writer.simple_tag ("img", {"src", "/images/external_link.png"});
			}
			writer.end_tag ("td");

			writer.start_tag ("td", {"style", "white-space:no wrap"}).text (pkg.get_documentation_source ()).end_tag ("td");

			writer.start_tag ("td", {"style", "white-space:no wrap"});

			bool first = true;
			if (pkg.home != null) {
				writer.start_tag ("a", {"href", pkg.home}).text ("Home").end_tag ("a");
				first = false;
			}
			if (pkg.c_docs != null) {
				if (first == false) {
					writer.text (", ");
				}

				writer.start_tag ("a", {"href", pkg.c_docs}).text ("C-docs").end_tag ("a");
				first = false;
			}
			if (first == true) {
				writer.text ("-");
			}
			writer.end_tag ("td");


			string? install_link = pkg.get_catalog_file ();
			if (install_link != null) {
				string html_link = Path.build_filename (pkg.name, Path.get_basename (install_link));
				writer.start_tag ("td", {"style", "white-space:no wrap"}).start_tag ("a", {"href", html_link}).text ("Install").end_tag ("a").end_tag ("td");
				Valadoc.copy_file (install_link, Path.build_filename (output_directory, html_link));
			} else {
				writer.start_tag ("td", {"style", "white-space:no wrap"}).text ("-").end_tag ("td");
			}

			if (pkg.devhelp_link != null) {
				writer.start_tag ("td", {"style", "white-space:no wrap"}).start_tag ("a", {"href", pkg.devhelp_link}).text ("devhelp-package").end_tag ("a").end_tag ("td");
			} else {
				writer.start_tag ("td", {"style", "white-space:no wrap"}).text ("-").end_tag ("td");
			}

			writer.start_tag ("td").end_tag ("td"); // space
			writer.end_tag ("tr");

			if (pkg.description != null) {
				writer.start_tag ("tr");
				writer.start_tag ("td").end_tag ("td");
				writer.start_tag ("td").end_tag ("td");
				writer.start_tag ("td", {"colspan", "5"});
				foreach (string line in pkg.description) {
					line._strip ();
					writer.start_tag ("p").text (line).end_tag ("p");
				}
				writer.end_tag ("td");
				writer.start_tag ("td").end_tag ("td");
				writer.end_tag ("tr");
			}

			writer.end_tag ("tbody");
		}

		private void render_table_end () {
			writer.end_tag ("table");
		}
	}

	private void generate_wiki_index (Package pkg, string path, bool has_examples, bool is_devhelp) {
		FileStream stream = FileStream.open (path, "w");
		assert (stream != null);

		if (pkg.description != null) {
			foreach (string line in pkg.description) {
				stream.puts (line);
				stream.putc ('\n');
			}
		}
		if (pkg.is_deprecated) {
			stream.puts ("\n''//Warning:// This package is deprecated!''\n");
		}

		if (pkg.is_deprecated || pkg.description != null) {
			stream.putc ('\n');
		}

		if (pkg.home != null) {
			stream.printf (" * ''Home:'' [[%s]]\n", pkg.home);
		}
		if (pkg.c_docs != null) {
			stream.printf (" * ''C-Documentation:'' [[%s]]\n", pkg.c_docs);
		}
		if (pkg.maintainers != null) {
			stream.printf (" * ''Binding-Maintainer(s): %s''\n", pkg.maintainers);
		}
		if (is_devhelp == false) {
			string? catalog = pkg.get_catalog_file ();
			if (catalog != null) {
				stream.printf (" * ''[[%s|Install this package]]'' (PackageKit required)\n", catalog);
			}
			if (pkg.devhelp_link != null) {
				stream.printf (" * ''[[%s|Devhelp-Package download]]''\n", pkg.devhelp_link);
			}
		}
		if (pkg.gallery != null) {
			stream.puts (" * ''[[widget-gallery.valadoc|Widget Gallery]]''\n");
		}
		if (has_examples) {
			stream.puts (" * ''[[example-listing-index.valadoc|Example listing]]''\n");
		}
	}

	private void generate_index (string path) {
		IndexRenderer renderer = new IndexRenderer ();
		renderer.render (path, sections);

		try {
			copy_data ();
		} catch (Error e) {
			reporter.simple_error ("error: Can't copy data: %s", e.message);
		}
	}

	public void generate (string path) {
		stdout.printf ("generate index ...\n");

		generate_navigation (path + ".navi.tpl");
		generate_index (path + ".content.tpl");
	}

	public void regenerate_all_known_packages () throws Error {
		foreach (var pkg in packages_per_name.values) {
			if (pkg is ExternalPackage == false) {
				build_doc_for_package (pkg);
			}
		}

		print_stored_messages ();
	}

	private string get_index_name (string pkg_name) {
		StringBuilder builder = new StringBuilder ();
		for (unowned string pos = pkg_name; pos.get_char () != '\0'; pos = pos.next_char ()) {
			unichar c = pos.get_char ();
			if (('A' <= c <= 'Z') || ('a' <= c <= 'z') || ('0' <= c <= '9')) {
				builder.append_unichar (c);
			}
		}

		return builder.str;
	}

	public void generate_configs (string path) throws Error {
		string constants_path = Path.build_filename (path, "constants.php");
		string path_prefix = Path.build_filename (path, "prefix.conf");

		var _prefix = FileStream.open (path_prefix, "w");
		_prefix.printf ("%s", prefix);

		var php = FileStream.open (constants_path, "w");
		bool first = true;

		php.printf ("<?php\n");
		php.printf ("\t$prefix = \"%s\";\n", prefix);
		php.printf ("\t$allpkgs = \"");
		foreach (Package pkg in packages_per_name.values) {
			if (pkg is ExternalPackage) {
				continue ;
			}

			if (first == false) {
				php.printf (",");
			}

			php.printf ("%s%s", prefix, get_index_name (pkg.name));
			first = false;
		}
		php.printf ("\";\n");
		php.printf ("?>\n");
	}

	/*
	public void generate_configs (string config_path) throws Error {
		string htaccess_path = Path.build_filename (config_path, ".htaccess");
		string sphinx_path = Path.build_filename (config_path, "sphinx.conf");
		string php_path = Path.build_filename (config_path, "constants.php");

		if (FileUtils.test (config_path, FileTest.EXISTS)) {
			FileUtils.unlink (htaccess_path);
			FileUtils.unlink (sphinx_path);
			FileUtils.unlink (php_path);
		}

		DirUtils.create (config_path, 0777);

		var php = FileStream.open (php_path, "w");
		php.printf ("<?php\n");
		php.printf ("\t$allpkgs = \"");


		var writer = FileStream.open (htaccess_path, "w");
		writer.printf ("Options -Indexes\n");
		writer.printf ("\n");
		writer.printf ("<Files ~ \"^\\.conf\">\n");
		writer.printf ("        Order allow,deny\n");
		writer.printf ("        Deny from all\n");
		writer.printf ("        Satisfy All\n");
		writer.printf ("</Files>\n");
		writer.printf ("\n\n");

		writer = FileStream.open (sphinx_path, "w");
		writer.printf ("searchd {\n");
		writer.printf ("        listen = 0.0.0.0:51413:mysql41\n");
		writer.printf ("        log = ./searchd.log\n");
		writer.printf ("        query_log = ./query.log\n");
		writer.printf ("        pid_file = ./searcd.pid\n");
		writer.printf ("}\n");

		writer.printf ("\n\n");

		writer.printf ("index base {\n");
		writer.printf ("        charset_type = utf-8\n");
		writer.printf ("        enable_star = 1\n");
		writer.printf ("        min_infix_len = 1\n");
		writer.printf ("        html_strip = 1\n");
		writer.printf ("        charset_table = 0..9, A..Z->a..z, ., _, a..z\n");
		writer.printf ("}\n");

		writer.printf ("source main {\n");
		writer.printf ("        type = xmlpipe2\n");
		writer.printf ("        xmlpipe_command = cat ../empty.xml\n");
		writer.printf ("}\n");

		writer.printf ("index main : base {\n");
		writer.printf ("        source = main\n");
		writer.printf ("        path = ./sphinx-main\n");
		writer.printf ("}\n");


		writer.printf ("\n\n");
		writer.printf ("\n\n");

		int startid = 0;

		foreach (var pkg in packages_per_name.values) {
			if (pkg is ExternalPackage == false) {
				string name = get_index_name (pkg.name);
				writer.printf ("source %s {\n", name);
				writer.printf ("        type = xmlpipe2\n");
				writer.printf ("        xmlpipe_command = xsltproc --stringparam startid %d ./sphinx.xsl ./../%s/index.xml\n", startid, pkg.name);
				writer.printf ("}\n");
				writer.printf ("\n\n");

				writer.printf ("index %s : base {\n", name);
				writer.printf ("        source = %s\n", name);
				writer.printf ("        path = ./sphinx-%s\n", name);
				writer.printf ("}\n");
				writer.printf ("\n\n");

				if (startid != 0) {
					php.printf (", ");
				}
				php.printf ("%s ", name);

				startid += 1000000;
			}
		}
		php.printf ("\";\n");
		php.printf ("?>\n");
	} */

	public void regenerate_packages (string[] packages) throws Error {
		LinkedList<Package> queue = new LinkedList<Package> ();

		foreach (string pkg_name in packages) {
			Package? pkg = packages_per_name.get (pkg_name);
			if (pkg == null) {
				reporter.simple_error ("error: Unknown package %s", pkg_name);
			}

			queue.add (pkg);
		}

		if (reporter.errors > 0) {
			return ;
		}

		foreach (Package pkg in queue) {
			build_doc_for_package (pkg);
		}

		print_stored_messages ();
	}

	private void build_doc_for_package (Package pkg) throws Error {
		if (skip_existing && FileUtils.test (Path.build_filename (output_directory, pkg.name), FileTest.IS_DIR)) {
			stdout.printf ("skip \'%s\' ...\n", pkg.name);
			return ;
		}

		if (pkg.get_vapi_path () == null) {
			this.unavailable_packages.add (pkg);
			return ;
		}

		stdout.printf ("create \'%s\' ...\n", pkg.name);


		DirUtils.create ("documentation/%s/".printf (pkg.name), 0755);
		DirUtils.create ("documentation/%s/wiki".printf (pkg.name), 0755);


		pkg.load_metadata (reporter);


		if (pkg.sgml_path != null) {
			stdout.printf ("  get index.sgml ...\n");

			if (!FileUtils.test ("documentation/%s/index.sgml".printf (pkg.name), FileTest.EXISTS)) {
				try {
					Process.spawn_command_line_sync ("wget -O documentation/%s/index.sgml \"%s\"".printf (pkg.name, pkg.sgml_path));
				} catch (SpawnError e) {
					assert_not_reached ();
				}
			}
		}


		StringBuilder builder = new StringBuilder ();
		builder.append_printf ("valadoc --target-glib %s --driver \"%s\" --importdir girs --doclet \"%s\" -o \"tmp/%s\" \"%s\" --vapidir \"%s\" --girdir \"%s\" %s", target_glib, driver, docletpath, pkg.name, pkg.get_vapi_path (), Path.get_dirname (pkg.get_vapi_path ()), girdir, pkg.flags);


		string external_docu_path = pkg.get_valadoc_file ();
		if (external_docu_path != null) {
			stdout.printf ("  select .valadoc:        %s\n".printf (external_docu_path));

			builder.append_printf (" --importdir documentation/%s", pkg.name);
			builder.append_printf (" --import %s", pkg.name);
		}

		string gir_path = pkg.get_gir_file ();
		if (gir_path != null) {
			stdout.printf ("  select .gir:            %s\n", gir_path);

			builder.append_printf (" --importdir \"%s\"", girdir);
			builder.append_printf (" --import %s", pkg.gir_name);

			load_images (pkg);

			string metadata_path = pkg.get_gir_file_metadata_path ();
			if (metadata_path != null) {
				builder.append_printf (" --metadatadir %s", metadata_path);
			}
		}

		if (pkg.gallery != null) {
			generate_widget_gallery (pkg);

			builder.append (" --importdir \"tmp\"");
			builder.append_printf (" --import \"%s-widget-gallery\"", pkg.name);
		}

		bool has_examples = false;
		string example_path = "examples/%s/%s.valadoc.examples".printf (pkg.name, pkg.name);
		if (FileUtils.test (example_path, FileTest.IS_REGULAR)) {
			string output = "examples/%s-examples.valadoc".printf (pkg.name);
			stdout.printf ("  select example.valadoc: %s\n", output);
			FileUtils.remove (output);

			try {
				int exit_status = 0;
				string? standard_output = null;
				string? standard_error = null;

				Process.spawn_command_line_sync ("./valadoc-example-gen \"%s\" \"%s\" \"%s\"".printf (example_path, output, "documentation/%s/wiki".printf (pkg.name)), out standard_output, out standard_error, out exit_status);
				if (exit_status != 0) {
					FileStream log = FileStream.open ("LOG", "w");
					log.printf ("%s\n", builder.str);
					if (standard_error != null) {
						log.printf (standard_error);
					}
					if (standard_output != null) {
						log.printf (standard_output);
					}
					throw new SpawnError.FAILED ("Exit status != 0");
				}
			} catch (SpawnError e) {
				stdout.printf ("ERROR: Can't generate documentation for %s. See LOG for details.\n", pkg.name);
				throw e;
			}

			builder.append_printf (" --importdir examples --import %s-examples", pkg.name);
			has_examples = true;
		}


		string wiki_path = "documentation/%s/wiki/index.valadoc".printf (pkg.name);
		bool delete_wiki_path = false;
		if (FileUtils.test (wiki_path, FileTest.IS_REGULAR)) {
			stdout.printf ("  select .valadoc (wiki): documentation/%s/wiki/*.valadoc\n", pkg.name);
		} else {
			string devhelp_wiki_path = "documentation/%s/wiki/devhelp-index.valadoc".printf (pkg.name);
			generate_wiki_index (pkg, devhelp_wiki_path, has_examples, true);
			generate_wiki_index (pkg, wiki_path, has_examples, false);
			delete_wiki_path = true;
		}
		builder.append_printf (" --wiki documentation/%s/wiki", pkg.name);


		try {
			int exit_status = 0;
			string? standard_output = null;
			string? standard_error = null;

			stdout.puts ("  run valadoc ...\n");
			Process.spawn_command_line_sync (builder.str, out standard_output, out standard_error, out exit_status);

			FileStream log = FileStream.open ("LOG", "w");
			log.printf ("%s\n", builder.str);
			if (standard_error != null) {
				log.printf (standard_error);
			}
			if (standard_output != null) {
				log.printf (standard_output);
			}
			standard_output = null;
			standard_error = null;
			log = null;

			if (exit_status != 0) {
				throw new SpawnError.FAILED ("Exit status != 0");
			}

			Process.spawn_command_line_sync ("rm -r -f %s".printf (Path.build_path (Path.DIR_SEPARATOR_S, output_directory, pkg.name)));
			Process.spawn_command_line_sync ("mv LOG tmp/%s/%s".printf (pkg.name, pkg.name));
			Process.spawn_command_line_sync ("mv tmp/%s/%s \"%s\"".printf (pkg.name, pkg.name, output_directory));
		} catch (SpawnError e) {
			stdout.printf ("ERROR: Can't generate documentation for %s. See LOG for details.\n", pkg.name);
			throw e;
		} finally {
			if (delete_wiki_path) {
				FileUtils.unlink (wiki_path);
			}
		}
	}

	private void collect_images (string content, HashSet<string> images, bool is_docbook) {
		if (is_docbook) {
			// Docbook:
			Gtkdoc.Scanner scanner = new Gtkdoc.Scanner ();
			scanner.reset (content);

			for (Gtkdoc.Token token = scanner.next (); token.type != Gtkdoc.TokenType.EOF; token = scanner.next ()) {
				if (token.type == Gtkdoc.TokenType.XML_OPEN && (token.content == "inlinegraphic" || token.content == "graphic")) {
					if (token.attributes == null) {
						continue ;
					}

					string? link = token.attributes.get ("fileref");
					if (link != null) {
						images.add (link);
					}
				}
			}
		} else {
			// Markdown:
			MatchInfo info;
			markdown_img_regex.match (content, 0, out info);
			int path_num = markdown_img_regex.get_string_number ("img");
			while (info.matches ()) {
				string link = info.fetch (path_num);
				images.add (link);
				info.next ();
			}
		}
	}

	private void generate_widget_gallery (Package pkg) throws Error {
		if (pkg.gallery == null) {
			return ;
		}

		int pos = pkg.gallery.last_index_of_char ('/');
		if (pos < 0) {
			reporter.simple_error ("Invalid widget gallery path\n");
			throw new FileError.FAILED ("Invalid widget gallery path");
		}
		string search_path = pkg.gallery.substring (0, pos);


		stdout.printf ("  widget gallery\n");

		if (!FileUtils.test ("tmp/c-gallery.html", FileTest.EXISTS)) {
			try {
				Process.spawn_command_line_sync ("wget -O tmp/c-gallery.html \"%s\"".printf (pkg.gallery));
			} catch (SpawnError e) {
				assert_not_reached ();
			}
		}

		HashMap<string, string> images = new HashMap<string, string> ();

		var markup_reader = new Valadoc.MarkupReader ("tmp/c-gallery.html", reporter);
		MarkupTokenType token = MarkupTokenType.START_ELEMENT;
		MarkupSourceLocation token_begin;
		MarkupSourceLocation token_end;

		token = markup_reader.read_token (out token_begin, out token_end);
		while (token != MarkupTokenType.EOF) {
			if (token == MarkupTokenType.START_ELEMENT && markup_reader.name == "div" && markup_reader.get_attribute ("class") == "gallery-float") {
				string? widget = null;
				string? img = null;

				token = markup_reader.read_token (out token_begin, out token_end);
				if (token == MarkupTokenType.START_ELEMENT && markup_reader.name == "a") {
					widget = markup_reader.get_attribute ("title");

					token = markup_reader.read_token (out token_begin, out token_end);
					if (token == MarkupTokenType.START_ELEMENT && markup_reader.name == "img") {
						img = markup_reader.get_attribute ("src");
						images.set (widget, img);
					} else {
						continue;
					}
				} else {
					continue;
				}
			}
			token = markup_reader.read_token (out token_begin, out token_end);
		}

		FileUtils.unlink ("tmp/c-gallery.html");



		DirUtils.create ("documentation/%s/gallery-images/".printf (pkg.name), 0755);

		// Download:
		if (download_images) {
			images.foreach ((entry) => {
			if (!FileUtils.test ("documentation/%s/gallery-images/%s".printf (pkg.name, entry.value), FileTest.EXISTS)) {
					try {
						string link = Path.build_path (Path.DIR_SEPARATOR_S, search_path, entry.value);
						Process.spawn_command_line_sync ("wget --directory-prefix documentation/%s/gallery-images/ \"%s\"".printf (pkg.name, link));
					} catch (SpawnError e) {
						assert_not_reached ();
					}
				}
				return true;
			});
		}

		FileStream stream = FileStream.open ("documentation/%s/wiki/widget-gallery.valadoc".printf (pkg.name), "w");
		assert (stream != null);

		stream.puts ("== Widget Gallery ==\n");
		stream.putc ('\n');

		images.foreach ((entry) => {
			stream.printf ("{@link c::%s}:\n", entry.key);
			stream.putc ('\n');
			stream.printf ("{{../gallery-images/%s|%s}}\n", entry.value, entry.key);
			stream.putc ('\n');
			return true;
		});


		stream = FileStream.open ("tmp/%s-widget-gallery.valadoc".printf (pkg.name), "w");
		assert (stream != null);

		bool first_entry = true;

		images.foreach ((entry) => {
			if (first_entry == false) {
				stream.puts ("\n\n");
			}

			stream.puts ("/**\n");
			stream.printf (" * {{../documentation/%s/gallery-images/%s|%s}}\n", pkg.name, entry.value, entry.key);
			stream.puts (" */\n");
			stream.printf ("c::%s::append", entry.key);

			first_entry = false;
			return true;
		});
	}

	private void load_images (Package pkg) {
		if (pkg.c_docs == null || pkg.gir_name == null) {
			return ;
		}

		if (!download_images) {
			return ;
		}


		string gir_path = pkg.get_gir_file ();

		stdout.printf ("  download images ...\n");

		var markup_reader = new Valadoc.MarkupReader (gir_path, reporter);
		MarkupTokenType token = MarkupTokenType.EOF;
		MarkupSourceLocation token_begin;
		MarkupSourceLocation token_end;

		HashSet<string> images = new HashSet<string> ();

		do {
			token = markup_reader.read_token (out token_begin, out token_end);

			if (token == MarkupTokenType.START_ELEMENT && markup_reader.name == "doc") {
				token = markup_reader.read_token (out token_begin, out token_end);
				if (token == MarkupTokenType.TEXT) {
					this.collect_images (markup_reader.content, images, pkg.is_docbook);
				}
			}
		} while (token != MarkupTokenType.EOF);

		foreach (string image_name in images) {
			if (!FileUtils.test ("documentation/%s/gir-images/%s".printf (pkg.name, image_name), FileTest.EXISTS)) {
				try {
					string link = Path.build_path (Path.DIR_SEPARATOR_S, pkg.c_docs, image_name);
					Process.spawn_command_line_sync ("wget --directory-prefix documentation/%s/gir-images/ \"%s\"".printf (pkg.name, link));
				} catch (SpawnError e) {
					assert_not_reached ();
				}
			}
		}


		if (images.size > 0) {
			string metadata_file_path = "documentation/%s/%s.valadoc.metadata".printf (pkg.name, pkg.gir_name);
			if (!FileUtils.test (metadata_file_path, FileTest.EXISTS)) {
				FileStream stream = FileStream.open (metadata_file_path, "w");
				stream.printf ("\n");
				stream.printf ("[General]\n");
				stream.printf ("resources = gir-images/\n");
				stream.printf ("\n");
			}
		}
	}

	private static void copy_dir (string path, string output) throws Error {
		Dir dir = Dir.open (path);
		for (string? file = dir.read_name (); file != null; file = dir.read_name ()) {
			string src_file_path = Path.build_filename (path, file);
			string dest_file_path = Path.build_filename (output, file);
			if (FileUtils.test (src_file_path, FileTest.IS_DIR)) {
				if (!FileUtils.test (dest_file_path, FileTest.EXISTS)) { // mkdir if necessary
					File.new_for_path (dest_file_path).make_directory (null);
				}
				copy_dir (src_file_path, dest_file_path); // copy directories recursively
			} else {
				Valadoc.copy_file (src_file_path, dest_file_path);
			}
		}
	}

	private void copy_data () throws Error {
		copy_dir ("data", output_directory);
	}

	public static int main (string[] args) {
		ErrorReporter reporter = new ErrorReporter ();

		try {
			var opt_context = new OptionContext ("- Vala Documentation Tool");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			stdout.printf ("error: %s", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return -1;
		}

		if (prefix == null) {
			stdout.printf ("error: prefix == null\n");
			return -1;
		}

		if (target_glib == null) {
			stdout.printf ("error: target_glib == null\n");
			return -1;
		}

		if (FileUtils.test (metadata_path, FileTest.IS_REGULAR)) {
			stdout.printf ("error: %s does not exist.\n", metadata_path);
			return -1;
		}

		if (FileUtils.test ("tmp", FileTest.IS_DIR)) {
			stdout.printf ("error: tmp already exist.\n");
			return -1;
		}

		if (output_directory == null) {
			output_directory = "valadoc.org";
		}

		if (driver == null) {
			stdout.printf ("error: --driver is missing\n");
			return -1;
		}

		if (metadata_path == null) {
			metadata_path = "documentation/packages.xml";
		}

		if (docletpath == null) {
			docletpath = ".";
		}

		if (vapidir == null) {
			stdout.printf ("error: --vapidir is missing\n");
			return -1;
		}


		if (!FileUtils.test (output_directory, FileTest.IS_DIR)) {
			if (DirUtils.create_with_parents (output_directory, 0777) != 0) {
				stdout.printf ("error: can't create output-directory: %s.\n", output_directory);
				return -1;
			}
		}

		if (DirUtils.create ("tmp", 0777) != 0) {
			stdout.printf ("error: can't create tmp/.\n");
			return -1;
		}


		int return_val = 0;

		try {
			IndexGenerator generator = new IndexGenerator (reporter);
			generator.load_metadata (metadata_path);
			if (reporter.errors > 0) {
				return -1;
			}

			generator.load (output_directory);
			if (reporter.errors > 0) {
				return -1;
			}

			if (regenerate_all_packages) {
				generator.regenerate_all_known_packages ();
			} else {
				generator.regenerate_packages (requested_packages);
			}

			if (reporter.errors > 0) {
				return -1;
			}

			string index = Path.build_path (Path.DIR_SEPARATOR_S, output_directory, "index.htm");
			generator.generate (index);

			generator.generate_configs (output_directory);

			if (reporter.errors > 0) {
				return -1;
			}

		} catch (Error e) {
			return_val = -1;
		}

		DirUtils.remove ("tmp");
		return return_val;
	}
}
