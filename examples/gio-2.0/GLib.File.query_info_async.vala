public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s FILE\n", args[0]);
		return 0;
	}

	MainLoop loop = new MainLoop ();

	File file = File.new_for_commandline_arg (args[1]);
	file.query_info_async.begin ("standard::icon", 0, Priority.DEFAULT, null, (obj, res) => {
		try {
			FileInfo info = file.query_info_async.end (res);
			Icon icon = info.get_icon ();
			print ("%s\n", icon.to_string ());
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
