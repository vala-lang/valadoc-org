public static int main (string[] args) {
	if (args.length < 2) {
		print ("Usage: %s FILE\n", args[0]);
		return 0;
	}

	File infile = File.new_for_commandline_arg (args[1]);
	if (!infile.query_exists ()) {
		stderr.printf ("File '%s' does not exist.\n", args[1]);
		return 1;
	}

	try {
		FileInputStream @is = infile.read ();
		BufferedInputStream bis = new BufferedInputStream (@is);

		StringBuilder builder = new StringBuilder ();
		uint8 buffer[100];
		ssize_t size;

		while ((size = bis.read (buffer)) > 0) {
			builder.append_len ((string) buffer, size);
		}

		print (builder.str);
	} catch (Error e) {
		stderr.printf ("Error: %s", e.message);
		return -1;
	}
	return 0;
}
