public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s FILE\n", args[0]);
		return 0;
	}

	File file = File.new_for_commandline_arg (args[1]);
	FileType type = file.query_file_type (FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
	print ("%s\n", type.to_string ());

	return 0;
}
