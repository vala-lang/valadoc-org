public static int main (string[] args) {
	if (args.length != 2) {
		print ("%s FILE\n", args[0]);
		return 0;
	}

	MainLoop loop = new MainLoop ();

	File file = File.new_for_commandline_arg (args[1]);
	file.replace_contents_async.begin ("My info\n".data, null, false, FileCreateFlags.NONE, null, (obj, res) => {
		try {
			file.replace_contents_async.end (res, null);
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
