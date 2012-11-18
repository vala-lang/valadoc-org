public static int main (string[] args) {
	if (args.length != 2) {
		stdout.printf ("%s FILE\n", args[0]);
		return 0;
	}

	MainLoop loop = new MainLoop ();

	File file = File.new_for_commandline_arg (args[1]);
	file.query_info_async.begin ("standard::icon", 0, Priority.DEFAULT, null, (obj, res) => {
		try {
			FileInfo info = file.query_info_async.end (res);
			Icon icon = info.get_icon ();
			stdout.printf ("%s\n", icon.to_string ());
		} catch (Error e) {
			stdout.printf ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
