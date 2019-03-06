
namespace Generator {
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? directories = null;
	private static string? template = null;
	private static int offset = 0;

	private FileStream config = null;

	private const GLib.OptionEntry[] options = {
		{"offset", 0, 0, OptionArg.INT, ref offset, "index offset", "INT"},
		{"template", 0, 0, OptionArg.FILENAME, ref template, "config template", "FILE"},
		{"", 0, 0, OptionArg.FILENAME_ARRAY, ref directories, null, "DIR..."},
		{null}
	};

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

	private void generate_config_entry (string _path) {
		string name = get_index_name (Path.get_basename (_path));
		string path = Path.build_filename (_path, "index.xml");
		string prefix = get_prefix (_path);

		config.printf ("source %s%s {\n", prefix, name);
		config.printf ("\ttype = xmlpipe2\n");
		config.printf ("\txmlpipe_command = xsltproc --stringparam startid %d \"%s/sphinx/sphinx.xsl\" \"%s\"\n",
			offset, Config.datadir, path);
		config.printf ("}\n");

		config.printf ("index %s%s : base {\n", prefix, name);
		config.printf ("\tsource = %s%s\n", prefix, name);
		config.printf ("\tpath = ./sphinx/storage/sphinx-%s-%s\n", prefix, name);

		config.printf ("}\n");
		config.printf ("\n\n");

		offset += 1000000;
 	}

	private bool is_vala_docu (string _path) {
		string path = Path.build_filename (_path, "img");
		if (!FileUtils.test (path, FileTest.IS_DIR)) {
			return false;
		}

		path = Path.build_filename (_path, "index.htm.content.tpl");
		if (!FileUtils.test (path, FileTest.IS_REGULAR)) {
			return false;
		}

		path = Path.build_filename (_path, "index.htm.content.tpl");
		if (!FileUtils.test (path, FileTest.IS_REGULAR)) {
			return false;
		}

		path = Path.build_filename (_path, "index.xml");
		if (!FileUtils.test (path, FileTest.IS_REGULAR)) {
			return false;
		}

		return true;
	}

	private string? get_prefix (string _path) {
		try {
			string path = Path.build_filename (_path, "..", "prefix.conf");
			string content;

			FileUtils.get_contents (path, out content);
			return content;
		} catch (FileError e) {
			error (e.message);
		}
	}

	private void scan_dir (string path) {
		if (is_vala_docu (path)) {
			generate_config_entry (path);
			return ;
		}

		try {
			Dir dir = Dir.open (path);
			string? name = null;

			while ((name = dir.read_name ()) != null) {
				string subpath = Path.build_filename (path, name);
				if (FileUtils.test (subpath, FileTest.IS_DIR)) {
					scan_dir (subpath);
				}
			}
		} catch (FileError e) {
			error (e.message);
		}
	}

	public static int main (string[] args) {
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

		config = FileStream.open ("sphinx.conf", "w");
		if (config == null) {
			stdout.printf ("error: unable to write to 'sphinx.conf': %s", GLib.strerror (GLib.errno));
			return -1;
		}

		if (template != null) {
			if (!FileUtils.test (template, FileTest.IS_REGULAR)) {
				stdout.printf ("template != file\n");
				return -1;
			}

			try {
				string content = null;
				FileUtils.get_contents (template, out content);
				config.printf (content);
				config.printf ("\n\n");
			} catch (Error e) {
				error (e.message);
			}
		}

    config.printf ("searchd {\n");
    config.printf ("\tlisten = 51413:mysql41\n");
    config.printf ("\tpid_file = ./sphinx/storage/searchd.pid\n");
    config.printf ("}\n");
    config.printf ("\n\n");

		config.printf ("index base {\n");
		config.printf ("\tmin_infix_len = 1\n");
		config.printf ("\thtml_strip = 1\n");
		config.printf ("\tcharset_table = 0..9, A..Z->a..z, ., _, a..z\n");
    config.printf ("\tpath = ./sphinx/storage/sphinx-base\n");
		config.printf ("}\n");
		config.printf ("\n\n");

		config.printf ("source main {\n");
		config.printf ("\ttype = xmlpipe2\n");
		config.printf ("\txmlpipe_command = cat \"%s/sphinx/empty.xml\"\n", Config.datadir);
		config.printf ("}\n");
		config.printf ("index main : base {\n");
		config.printf ("\tsource = main\n");
    config.printf ("\tpath = ./sphinx/storage/sphinx-main\n");
		config.printf ("}\n");
		config.printf ("\n\n");

		foreach (string dir in directories) {
			if (FileUtils.test (dir, FileTest.IS_DIR)) {
				scan_dir (dir);
			}
		}

		return 0;
	}
}
