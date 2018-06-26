public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s DIRECTORY\n", args[0]);
		return 0;
	}

	File file = File.new_for_commandline_arg (args[1]);
	for (File pos = file; pos != null; pos = pos.get_parent ()) {
		print ("%s\n", pos.get_path ());
	}

	return 0;
}
