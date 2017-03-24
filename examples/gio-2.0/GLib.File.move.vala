public static int main (string[] args) {
	if (args.length != 3) {
		print ("%s SRC DEST\n", args[0]);
		return 0;
	}

	File src = File.new_for_commandline_arg (args[1]);
	File dest = File.new_for_commandline_arg (args[2]);

	try {
		src.move (dest, FileCopyFlags.NONE, null, (current_num_bytes, total_num_bytes) => {
			print ("%" + int64.FORMAT + " %" + int64.FORMAT + "\n", current_num_bytes, total_num_bytes);
		});
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
