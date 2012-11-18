public static int main (string[] args) {
	if (args.length != 2) {
		stdout.printf ("%s [FILE]\n", args[0]);
		return 0;
	}

	// Create a file that can only be accessed by the current user:
	File file = File.new_for_commandline_arg (args[1]);
	try {
		FileOutputStream os = file.create (FileCreateFlags.PRIVATE);
		os.write ("My first line\n".data);
		stdout.printf ("Created.\n");
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
