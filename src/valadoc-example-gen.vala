public class ValadocGen : ExampleParser {
	private List<string> nodes = new List<string> ();
	private StringBuilder builder = new StringBuilder ();
	private FileStream current_example;
	private FileStream listing;
	private FileStream output;
	private string wiki_path;
	private int sample_count;

	public ValadocGen (string output_path, string wiki_path) throws FileError {
		this.wiki_path = wiki_path;

		this.output = FileStream.open (output_path, "w");
		if (this.output == null) {
			throw new FileError.FAILED (strerror (errno));
		}

		string index_path = Path.build_filename (wiki_path, "example-listing-index.valadoc");
		this.listing = FileStream.open (index_path, "w");
		if (this.listing == null) {
			throw new FileError.FAILED (strerror (errno));
		}

		this.listing.puts ("==Example listing:==\n");
		this.listing.puts ("\n");
		write_example_navi (this.listing, false);
	}

	private void write_example_navi (FileStream stream, bool with_example_index) {
		stream.puts (" * {{data/images/package.svg}} [[index.valadoc|Package Index]]\n");
		if (with_example_index) {
			stream.puts (" * {{data/images/tip.svg}} [[example-listing-index.valadoc|Example Listing]]\n");
		}
		stream.puts ("\n");
	}

	protected override void examples_start () {
		sample_count = 0;
	}

	protected override void examples_end () {
		this.listing.puts ("\n");
		write_example_navi (this.listing, false);
	}

	protected override void example_start (bool deprecated, bool experimental) {
		builder.append ("/**\n");
		sample_count++;
	}

	protected override void example_end () {
		builder.append (" */\n");

		foreach (string node in nodes) {
			output.puts (builder.str);
			output.puts (node);
			output.puts ("::append\n");
		}

		if (nodes.length () > 0) {
			current_example.puts ("\n");
			current_example.puts ("===See:===\n");
			current_example.puts ("\n");
			foreach (string node in nodes) {
				current_example.printf (" * {@link %s}\n", node);
			}
			current_example.puts ("\n");

			write_example_navi (current_example, true);
		}

		nodes = new List<string> ();
		builder.erase ();
	}

	protected override void image (string image) {
		builder.append (" *\n");
		builder.append_printf (" * {{%s}}\n" , image);

		current_example.puts ("\n");
		current_example.printf ("{{%s}}\n", image);
	}

	protected override void compile (string str) {
		builder.append (" *\n");
		builder.append (" * {{{\n");
		builder.append_printf (" * %s\n", str);
		builder.append (" * }}}\n");

		current_example.puts ("\n");
		current_example.puts ("{{{\n");
		current_example.printf (" %s\n", str);
		current_example.puts ("}}}\n");
	}

	private string title_to_filename (string? title, int sample_count) {
		try {
			string current_name = "example-listing-%d-%s".printf (sample_count,
				(title == null)? "untitled-example" : title.replace (" ", "-"));

			current_name = current_name.down ();
			current_name.canon ("abcdefghijklmnopqrstuvwxyz1234567890", '-');

			Regex regex = new Regex ("-+");
			return regex.replace (current_name, current_name.length, 0, "-") + ".valadoc";
		} catch (Error e) {
			assert_not_reached ();
		}
	}

	protected override void title (string? str) {
		string title = null;

		if (str != null) {
			str._strip ();
			if (str.has_prefix (":")) {
				title = str.substring (0, str.length - 1);
			} else {
				title = str;
			}
		}


		if (title != null) {
			builder.append_printf (" * ''Example:'' //%s://\n", title);
		} else {
			builder.append (" * ''Example:''\n");
		}

		// We don't care about unexpected chars for now
		string current_name = title_to_filename (str, sample_count);
		string current_path = Path.build_filename (wiki_path, current_name);
		current_example = FileStream.open (current_path, "w");
		if (current_example == null) {
			stdout.printf ("Error: %s\n", strerror (errno));
			assert_not_reached ();
		}

		if (title != null) {
			current_example.printf ("==Example: %s==\n", title);
		} else {
			current_example.puts ("==Untitled example:==\n");
		}

		current_example.puts ("\n");
		write_example_navi (current_example, true);

		// TODO: General description?

		listing.printf (" i. [[%s|%s]]\n", current_name, title ?? "Untitled example");
	}

	protected override void note (string note) {
		builder.append (" *\n");
		builder.append_printf (" * Note: %s\n", note);

		current_example.puts ("\n");
		current_example.printf (" Note: %s\n", note);
	}

	protected override void file (string file) {
		string lang = "";
		if (file.has_suffix (".c") || file.has_suffix (".h")) {
			lang = "#!C";
		} else if (file.has_suffix (".vala") || file.has_suffix (".vapi")) {
			lang = "#!vala";
		} else if (file.has_suffix (".xml") || file.has_suffix (".ui")) {
			lang = "#!xml";
		} else {
			lang = "";
		}

		builder.append (" *\n");
		builder.append_printf (" * {{{%s\n", lang);

		current_example.puts ("\n");
		current_example.puts ("{{{\n");

		FileStream stream = FileStream.open (file, "r");
		if (stream == null) {
			// TODO
		} else {
			string line;
			while ((line = stream.read_line ()) != null) {
				builder.append_printf (" * %s\n", line);
				current_example.printf ("%s\n", line);
			}
		}
		builder.append (" * }}}\n");

		current_example.puts ("}}}\n");
	}

	protected override void run (string cmnd) {
		builder.append (" *\n");
		builder.append (" * {{{\n");
		builder.append_printf (" * %s\n", cmnd);
		builder.append (" * }}}\n");

		current_example.puts ("\n");
		current_example.puts ("{{{\n");
		current_example.printf ("%s\n", cmnd);
		current_example.puts ("}}}\n");
	}

	protected override void node (string node) {
		nodes.append (node);
	}

	public static int main (string[] args) {
		if (args.length != 4) {
			stdout.printf ("%s FILE COMMENT-OUTPUT WIKI-DIR\n", args[0]);
			return 0;
		}

		if (args[1].has_suffix (".valadoc.examples") == false) {
			stdout.printf ("Unexpected input file format.\n");
			return 0;
		}

		if (args[2].has_suffix (".valadoc") == false) {
			stdout.printf ("Invalid output file name.\n");
			return 0;
		}

		if (!FileUtils.test (args[3], FileTest.IS_DIR)) {
			stdout.printf ("%s is not a valid path.\n", args[3]);
			return 0;
		}

		try {
			ValadocGen parser = new ValadocGen (args[2], args[3]);
			parser.parse (args[1]);
		} catch (Error e) {
			stdout.printf ("Error: %s\n", e.message);
		}
		return 0;
	}
}
