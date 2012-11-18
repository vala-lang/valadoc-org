public static int main (string[] args) {
	if (args.length != 3) {
		stdout.printf ("%s FILE NEW-NAME\n", args[0]);
		return 0;
	}

	try {
		File file = File.new_for_commandline_arg (args[1]);
		file.set_display_name (args[2]);
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
