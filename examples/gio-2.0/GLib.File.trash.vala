public static int main (string[] args) {
	if (args.length != 2) {
		stdout.printf ("%s FILE\n", args[0]);
		return 0;
	}

	try {
		File file = File.new_for_commandline_arg (args[1]);
		file.trash ();
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}
	return 0;
}
