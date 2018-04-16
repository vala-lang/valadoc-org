public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s FILE\n", args[0]);
		return 0;
	}

	try {
		File file = File.new_for_commandline_arg (args[1]);
		FileIOStream iostream = file.open_readwrite ();
		iostream.seek (0, SeekType.END);

		OutputStream ostream = iostream.output_stream;
		DataOutputStream dostream = new DataOutputStream (ostream);
		dostream.put_string ("new-line\n");
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
