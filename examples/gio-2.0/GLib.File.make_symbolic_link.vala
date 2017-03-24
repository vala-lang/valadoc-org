public static int main (string[] args) {
	if (args.length != 3) {
		print ("%s FILE LINK\n", args[0]);
		return 0;
	}

	try {
		File file = File.new_for_commandline_arg (args[2]);
		file.make_symbolic_link (args[1]);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
