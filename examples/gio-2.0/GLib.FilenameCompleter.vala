private void print_array (string title, string[] arr) {
	print ("%s:\n", title);
	foreach (string str in arr) {
		print (" %s\n", str);
	}
}

public static int main (string[] args) {
		if (args.length != 2) {
			print ("%s [PATH-PREFIX]\n", args[0]);
			return 0;
		}

		// Example output:
		// ./GLib.FilenameCompleter "/usr/s"
		//  ``Init:``
		//  ``Got:``
		//  `` /usr/sbin/``
		//  `` /usr/share/``
		//  `` /usr/src/``

		FilenameCompleter completer = new FilenameCompleter ();
		string[] arr = completer.get_completions (args[1]);
		print_array ("Init", arr);

		completer.got_completion_data.connect (() => {
			arr = completer.get_completions (args[1]);
			print_array ("Got", arr);
		});

		MainLoop loop = new MainLoop ();
		loop.run ();
	return 0;
}
