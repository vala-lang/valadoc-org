public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s FILE\n", args[0]);
		return 0;
	}

	try {
		uint8[] contents;
		string etag_out;

		File file = File.new_for_commandline_arg (args[1]);
		file.load_contents (null, out contents, out etag_out);

		print ("%s", (string) contents);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
