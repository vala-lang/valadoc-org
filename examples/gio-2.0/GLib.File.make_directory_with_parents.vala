public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s NEW-DIRECTORY-NAME\n", args[0]);
		return 0;
	}

	try {
		File file = File.new_for_commandline_arg (args[1]);
		file.make_directory_with_parents ();
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
