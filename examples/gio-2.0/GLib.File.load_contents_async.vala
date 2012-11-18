public static int main (string[] args) {
	if (args.length != 2) {
		stdout.printf ("%s FILE\n", args[0]);
		return 0;
	}

	MainLoop loop = new MainLoop ();

	File file = File.new_for_commandline_arg (args[1]);
	file.load_contents_async.begin (null, (obj, res) => {
		try {
			uint8[] contents;
			string etag_out;

			file.load_contents_async.end (res, out contents, out etag_out);
			stdout.printf ("%s", (string) contents);
		} catch (Error e) {
			stdout.printf ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
