public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s FILE\n", args[0]);
		return 0;
	}

	try {
		File file = File.new_for_commandline_arg (args[1]);
		FileIOStream iostream = file.replace_readwrite (null, false, FileCreateFlags.NONE);

		OutputStream ostream = iostream.output_stream;
		DataOutputStream dostream = new DataOutputStream (ostream);
		dostream.put_string ("my-line\n");
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
