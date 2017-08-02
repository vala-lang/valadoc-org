private int count_children (File file, Cancellable? cancellable = null) throws Error {
	FileEnumerator enumerator = file.enumerate_children (
		"standard::*",
		FileQueryInfoFlags.NOFOLLOW_SYMLINKS,
		cancellable);

	FileInfo info = null;
	int counter = 0;

	while (cancellable.is_cancelled () == false && ((info = enumerator.next_file (cancellable)) != null)) {
		if (info.get_file_type () == FileType.DIRECTORY) {
			File subdir = file.resolve_relative_path (info.get_name ());
			counter += count_children (subdir, cancellable);
		}

		counter++;
	}

	if (cancellable.is_cancelled ()) {
		throw new IOError.CANCELLED ("Operation was cancelled");
	}

	return counter;
}

public async int count_children_async (File file, Cancellable? cancellable = null) throws Error {
	Error e = null;
	int result = -1;

	// Job runs in a new thread:
	IOSchedulerJob.push ((job, cancellable) => {
		try {
			result = count_children (file, cancellable);
		} catch (Error err) {
			e = err;
		}

		// Run the user-callback in the thread that the job was started from:
		job.send_to_mainloop (() => {
			print ("user-callback, start\n");
			count_children_async.callback ();
			print ("user-callback, end\n");
			return false;
		});

		return false;
	}, Priority.DEFAULT, cancellable);

	yield;

	if (e != null) {
		throw e;
	}

	return result;
}

public static int main (string[] args) {
	Cancellable cancellable = new Cancellable ();
	MainLoop loop = new MainLoop ();

	if (args.length != 2) {
		print ("%s [DIRECTORY]\n", args[0]);
		return 0;
	}

	// Output:
	//  ``user-callback, start``
	//  ``120``
	//  ``user-callback, end``
	count_children_async.begin (File.new_for_commandline_arg (args[1]), cancellable, (obj, res) => {
		try {
			int i = count_children_async.end (res);
			print ("%d\n", i);
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
