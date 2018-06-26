public static int main (string[] args) {
	if (args.length != 3) {
		print ("%s FILE NEW-NAME\n", args[0]);
		return 0;
	}

	MainLoop loop = new MainLoop ();

	File file = File.new_for_commandline_arg (args[1]);
	file.set_display_name_async.begin (args[2], Priority.DEFAULT, null, (obj, res) => {
		try {
			file.set_display_name_async.end (res);
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
