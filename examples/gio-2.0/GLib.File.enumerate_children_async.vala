public static int main (string[] args) {
	File file = File.new_for_path (".");
	MainLoop loop = new MainLoop ();

	file.enumerate_children_async.begin ("standard::*", FileQueryInfoFlags.NOFOLLOW_SYMLINKS, Priority.DEFAULT, null, (obj, res) => {
		try {
			FileEnumerator enumerator = file.enumerate_children_async.end (res);
			FileInfo info;
			while ((info = enumerator.next_file (null)) != null) {
				print ("%s\n", info.get_name ());
				print ("\t%s\n", info.get_file_type ().to_string ());
				print ("\t%s\n", info.get_is_symlink ().to_string ());
				print ("\t%s\n", info.get_is_hidden ().to_string ());
				print ("\t%s\n", info.get_is_backup ().to_string ());
				print ("\t%"+int64.FORMAT+"\n", info.get_size ());
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
