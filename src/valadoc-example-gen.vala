public class ValadocGen : ExampleParser {
	private List<string> nodes = new List<string> ();
	private StringBuilder builder = new StringBuilder ();
	private FileStream output;

	public ValadocGen (string output_path) throws FileError {
		this.output = FileStream.open (output_path, "w");
		if (this.output == null) {
			throw new FileError.FAILED (strerror (errno));
		}
	}

	protected override void examples_start () {
	}

	protected override void examples_end () {
	}

	protected override void example_start () {
		builder.append ("/**\n");
	}

	protected override void example_end () {
		builder.append (" */\n");

		foreach (string node in nodes) {
			output.puts (builder.str);
			output.puts (node);
			output.puts ("::append\n");
		}

		nodes = new List<string> ();
		builder.erase ();
	}

	protected override void image (string image) {
		builder.append (" *\n");
		builder.append_printf (" * {{%s}}\n" , image);
	}

	protected override void compile (string str) {
		builder.append (" *\n");
		builder.append (" * {{{\n");
		builder.append_printf (" * %s\n", str);
		builder.append (" * }}}\n");
	}

	protected override void title (string str) {
		builder.append_printf (" * ''%s''\n", str);
	}

	protected override void note (string note) {
		builder.append (" *\n");
		builder.append_printf (" * Note: %s\n", note);
	}

	protected override void file (string file) {
		builder.append (" *\n");
		builder.append (" * {{{\n");
		FileStream stream = FileStream.open (file, "r");
		if (stream == null) {
			// TODO
		} else {
			string line;
			while ((line = stream.read_line ()) != null) {
				builder.append_printf (" * %s\n", line);
			}
		}
		builder.append (" * }}}\n");
	}

	protected override void run (string cmnd) {
		builder.append (" *\n");
		builder.append (" * {{{\n");
		builder.append_printf (" * %s\n", cmnd);
		builder.append (" * }}}\n");
	}

	protected override void node (string node) {
		nodes.append (node);
	}

	public static int main (string[] args) {
		if (args.length != 3) {
			stdout.printf ("%s FILE OUTPUT\n", args[0]);
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

		try {
			ValadocGen parser = new ValadocGen (args[2]);
			parser.parse (args[1]);
		} catch (Error e) {
			stdout.printf ("Error: %s\n", e.message);
		}
		return 0;
	}
}
