private void list_children (File file, string space = "", Cancellable? cancellable = null) throws Error {
	FileEnumerator enumerator = file.enumerate_children (
		"standard::*",
		FileQueryInfoFlags.NOFOLLOW_SYMLINKS, 
		cancellable);

	FileInfo info = null;
	while (cancellable.is_cancelled () == false && ((info = enumerator.next_file (cancellable)) != null)) {
		if (info.get_file_type () == FileType.DIRECTORY) {
			File subdir = file.resolve_relative_path (info.get_name ());
			list_children (subdir, space + " ", cancellable);
		} else {
			print ("%s%s\n", space, info.get_name ());
			print ("%s %s\n", space, info.get_file_type ().to_string ());
			print ("%s %s\n", space, info.get_is_symlink ().to_string ());
			print ("%s %s\n", space, info.get_is_hidden ().to_string ());
			print ("%s %s\n", space, info.get_is_backup ().to_string ());
			print ("%s %"+int64.FORMAT+"\n", space, info.get_size ());
		}
	}

	if (cancellable.is_cancelled ()) {
		throw new IOError.CANCELLED ("Operation was cancelled");
	}
}

public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s [DIRECTORY]\n", args[0]);
		return 0;
	}

	File file = File.new_for_commandline_arg (args[1]);

	try {
		list_children (file, "", new Cancellable ());
	} catch (Error e) {
		print ("Error: %s\n", e.message);
		return 0;
	}

	return 0;
}
