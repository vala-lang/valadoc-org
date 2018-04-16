public static int main (string[] args) {
	File file = File.new_for_commandline_arg (args[0]);

	MainLoop loop = new MainLoop ();

	file.find_enclosing_mount_async.begin (Priority.DEFAULT, null, (obj, res) => {
		try {
			Mount mount = file.find_enclosing_mount_async.end (res);
			print ("%s\n", mount.get_name ());
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
