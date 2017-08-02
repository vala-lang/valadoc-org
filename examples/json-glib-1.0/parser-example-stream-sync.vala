public static int main (string[] args) {
	if (args.length < 2) {
		print ("Usage: test <filename.json>\n");
		return -1;
	}

	// Load a file:
	Json.Parser parser = new Json.Parser ();
	try {
		File file = File.new_for_commandline_arg (args[1]);
		FileInputStream stream = file.read ();
		parser.load_from_stream (stream);
	} catch (Error e) {
		print ("Unable to parse `%s': %s\n", args[1], e.message);
		return -1;
	}


	// Get the root node:
	Json.Node node = parser.get_root ();

	// manipulate/read the object tree and then exit
	// ...

	node = null;
	return 0;
}
