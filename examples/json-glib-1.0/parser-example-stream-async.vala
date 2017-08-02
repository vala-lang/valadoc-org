public static int main (string[] args) {
	if (args.length < 2) {
		print ("Usage: test <filename.json>\n");
		return -1;
	}

	MainLoop loop = new MainLoop ();

	// Load a file:
	File file = File.new_for_commandline_arg (args[1]);
	file.read_async.begin (Priority.DEFAULT, null, (obj, res) => {
		try {
			FileInputStream stream = file.read_async.end (res);

			Json.Parser parser = new Json.Parser ();
			parser.load_from_stream_async.begin (stream, null, (obj, res) => {
				try {
					parser.load_from_stream_async.end (res);

					// Get the root node:
					Json.Node node = parser.get_root ();

					// manipulate/read the object tree and then exit
					// ...

					node = null;
				} catch (Error e) {
					print ("Unable to parse `%s': %s\n", args[1], e.message);
				}

				loop.quit ();
			});
		} catch (Error e) {
			print ("Error: Can't read file: %s\n", e.message);
			loop.quit ();
		}
	});

	loop.run ();
	return 0;
}
