/* doclet.vala
 *
 * Copyright (C) 2012 Florian Brosch
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

public class Valadoc.ValadocOrgDoclet : Valadoc.Html.BasicDoclet {
	public const string css_path_package = "styles/main.css";
	public const string css_path_wiki = "../styles/main.css";
	public const string css_path = "../styles/main.css";

	public const string js_path_package = "scripts/main.js";
	public const string js_path_wiki = "../scripts/main.js";
	public const string js_path = "../scripts/main.js";

	private IndexMarkupWriter index_xml;

	private class IndexMarkupWriter : MarkupWriter {
		//unowned FileStream stream;

		public IndexMarkupWriter (FileStream stream) {
			// avoid broken implicit copy
			unowned FileStream _stream = stream;

			base ((str) => { _stream.printf (str); }, true);
			//this.stream = stream;
		}

		protected override bool inline_element (string name) {
			return name != "package";
		}

		protected override bool content_inline_element (string name) {
			return name == "node";
		}
	}

	construct {
		package_list_link = "/index.htm";
	}

	private void register_package_start (Api.Package pkg, string path) {
		index_xml.start_tag ("package", {"name", pkg.name});
	}

	private void register_package_end (Api.Package pkg, string path) {
		index_xml.end_tag ("package");
	}

	private void register_node (Api.Node node) {
		StringBuilder builder = new StringBuilder ();
		Html.MarkupWriter writer = new Html.MarkupWriter.builder (builder, false);
		Html.HtmlRenderer renderer = new Html.HtmlRenderer (settings, linker, cssresolver);
		renderer.set_container (node.package);
		renderer.set_writer (writer);
		writer.set_wrap (false);

		renderer.render (node.signature);
		string signature = builder.str;
		builder.erase ();

		if (node.documentation != null && node.documentation.content.size > 0 && node.documentation.content[0] is Content.Paragraph) {
			renderer.render (node.documentation.content[0]);
		}

		string shortdesc = (owned) builder.str;
		builder = null;

		string path = get_link (node, node.package);

		index_xml.simple_tag ("node", {"name", node.get_full_name ().replace ("@", ""), "css", this.cssresolver.resolve (node),
			"type", node.node_type.to_string (), "path", path, "signature", MarkupWriter.escape (signature), "shortdesc",
			MarkupWriter.escape (shortdesc)});
	}

	private string? create_checksum_for_file (string file_path) {
		FileStream stream = FileStream.open (file_path, "r");
		if (stream == null) {
			return null;
		}

		Checksum sum = new Checksum (ChecksumType.MD5);
		uint8 buf[500];

		while (stream.eof () == false) {
			size_t size = stream.read (buf);
			sum.update (buf, size);
		}

		return sum.get_string ();
	}

	private bool build_devhelp_book () {
		string? doclet_path = ModuleLoader.get_doclet_path ("devhelp", reporter);
		if (doclet_path == null) {
			reporter.simple_error (null, "error: failed to load doclet");
			return false;
		}

		ModuleLoader loader = ModuleLoader.get_instance ();
		Html.BasicDoclet? doclet = loader.create_doclet (doclet_path) as Html.BasicDoclet;
		if (doclet == null) {
			reporter.simple_error (null, "error: failed to load doclet");
			return false;
		}

		doclet.wiki_index_name = "devhelp-index.valadoc";

		string settings_directory = settings.directory;
		string settings_path = settings.path;

		settings.directory = Path.build_path (Path.DIR_SEPARATOR_S, settings_directory, settings.pkg_name);
		settings.path = Path.build_path (Path.DIR_SEPARATOR_S, settings_path, settings.pkg_name);

		doclet.process (settings, tree, reporter);

		try {
			string file_name = Path.build_filename (settings_path, settings.pkg_name, settings.pkg_name + ".tar.bz2");
			string rm_path = Path.build_path (Path.DIR_SEPARATOR_S, settings_path, settings.pkg_name, settings.pkg_name);
			string c_path = Path.build_path (Path.DIR_SEPARATOR_S, settings_path, settings.pkg_name);

			Process.spawn_sync (null, {"tar", "-jcf", file_name, "-C", c_path, settings.pkg_name}, null, SpawnFlags.SEARCH_PATH, null);
			Process.spawn_sync (null, {"rm", "-r", rm_path}, null, SpawnFlags.SEARCH_PATH, null);

			FileStream stream = FileStream.open (file_name + ".md5", "w");
			stream.printf ("%s", create_checksum_for_file (file_name));
		} catch (SpawnError e) {
			reporter.simple_error (null, "error: failed to tar: %s", e.message);
		}

		settings.directory = settings_directory;
		settings.path = settings_path;

		return (reporter.errors == 0);
	}

	private string get_real_path (Api.Node element) {
		return GLib.Path.build_filename (this.settings.path, element.package.name, element.get_full_name () + ".html");
	}

	protected override void write_wiki_page (WikiPage page, string contentp, string css_path, string js_path, string pkg_name) {
		string basic_path = Path.build_filename(contentp, page.name.substring (0, page.name.length-7).replace ("/", ".")+"htm");

		GLib.FileStream file = GLib.FileStream.open (basic_path + ".content.tpl", "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);

		_renderer.set_container (page);
		_renderer.render (page.documentation);

		file = GLib.FileStream.open (basic_path + ".navi.tpl", "w");
	}

	public override void process (Settings settings, Api.Tree tree, ErrorReporter reporter) {
		if (settings.with_deps == true) {
			reporter.simple_warning (null, "warning: --deps not supported by valadoc.org-doclet");
			settings.with_deps = false;
		}

		base.process (settings, tree, reporter);

		this.linker = new ValadocOrgLinkHelper ();
		_renderer = new Html.HtmlRenderer (settings, this.linker, this.cssresolver);
		this.image_factory = new Html.SimpleChartFactory (settings, linker);

		DirUtils.create_with_parents (this.settings.path, 0777);

		write_wiki_pages (tree, css_path_wiki, js_path_wiki, Path.build_filename(settings.path, settings.pkg_name));
		tree.accept (this);
	}

	public override void visit_tree (Api.Tree tree) {
		tree.accept_children (this);
	}

	public override void visit_package (Api.Package package) {
		if (!package.is_browsable (settings)) {
			return ;
		}

		string pkg_name = package.name;
		string path = GLib.Path.build_filename (this.settings.path, pkg_name);


		if (settings.pluginargs == null || ("--disable-devhelp" in settings.pluginargs) == false) {
			if (!build_devhelp_book ()) {
				return ;
			}
		}

		var rt = DirUtils.create (path, 0777);
		rt = DirUtils.create (GLib.Path.build_filename (path, "img"), 0777);

		FileStream index_xml_file = FileStream.open (GLib.Path.build_filename (path, "index.xml"), "w");
		index_xml = new IndexMarkupWriter (index_xml_file);

		string index_path = GLib.Path.build_filename (path, "index.htm");
		register_package_start (package, index_path);

		GLib.FileStream file = GLib.FileStream.open (index_path + ".navi.tpl", "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);
		write_navi_package (package);

		file = GLib.FileStream.open (index_path + ".content.tpl", "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);
		write_package_content (package, package);


		package.accept_all_children (this);

		register_package_end (package, index_path);
	}

	public override void visit_namespace (Api.Namespace ns) {
		string rpath = this.get_real_path (ns);

		if (ns.name != null) {
			register_node (ns);

			GLib.FileStream file = GLib.FileStream.open (rpath + ".navi.tpl", "w");
			writer = new Html.MarkupWriter (file, false);
			_renderer.set_writer (writer);
			write_navi_symbol (ns);

			file = GLib.FileStream.open (rpath + ".content.tpl", "w");
			writer = new Html.MarkupWriter (file, false);
			_renderer.set_writer (writer);
			write_namespace_content (ns, ns);
		}

		ns.accept_all_children (this);
	}

	private void process_node (Api.Node node, bool accept_all_children) {
		string rpath = this.get_real_path (node);
		register_node (node);


		GLib.FileStream file = GLib.FileStream.open (rpath + ".navi.tpl", "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);

		if (is_internal_node (node)) {
			write_navi_symbol (node);
		} else {
			write_navi_leaf_symbol (node);
		}


		file = GLib.FileStream.open (rpath + ".content.tpl", "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);
		write_symbol_content (node);


		if (accept_all_children) {
			node.accept_all_children (this);
		}
	}

	public override void visit_interface (Api.Interface item) {
		process_node (item, true);
	}

	public override void visit_class (Api.Class item) {
		process_node (item, true);
	}

	public override void visit_struct (Api.Struct item) {
		process_node (item, true);
	}

	public override void visit_error_domain (Api.ErrorDomain item) {
		process_node (item, true);
	}

	public override void visit_enum (Api.Enum item) {
		process_node (item, true);
	}

	public override void visit_property (Api.Property item) {
		process_node (item, false);
	}

	public override void visit_constant (Api.Constant item) {
		process_node (item, false);
	}

	public override void visit_field (Api.Field item) {
		process_node (item, false);
	}

	public override void visit_error_code (Api.ErrorCode item) {
		process_node (item, false);
	}

	public override void visit_enum_value (Api.EnumValue item) {
		process_node (item, false);
	}

	public override void visit_delegate (Api.Delegate item) {
		process_node (item, false);
	}

	public override void visit_signal (Api.Signal item) {
		process_node (item, false);
	}

	public override void visit_method (Api.Method item) {
		process_node (item, false);
	}
}


public Type register_plugin (Valadoc.ModuleLoader module_loader) {
	return typeof (Valadoc.ValadocOrgDoclet);
}
