public static int main (string[] args) {
	if (args.length != 2) {
		stdout.printf ("%s FILE\n", args[0]);
		return 0;
	}

	try {
		uint8[] contents;
		string etag_out;

		File file = File.new_for_commandline_arg (args[1]);
		file.load_contents (null, out contents, out etag_out);

		stdout.printf ("%s", (string) contents);
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
