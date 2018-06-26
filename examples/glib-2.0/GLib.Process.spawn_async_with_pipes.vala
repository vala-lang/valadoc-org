private static bool process_line (IOChannel channel, IOCondition condition, string stream_name) {
	if (condition == IOCondition.HUP) {
		print ("%s: The fd has been closed.\n", stream_name);
		return false;
	}

	try {
		string line;
		channel.read_line (out line, null, null);
		print ("%s: %s", stream_name, line);
	} catch (IOChannelError e) {
		print ("%s: IOChannelError: %s\n", stream_name, e.message);
		return false;
	} catch (ConvertError e) {
		print ("%s: ConvertError: %s\n", stream_name, e.message);
		return false;
	}

	return true;
}

public static int main (string[] args) {
	MainLoop loop = new MainLoop ();
	try {
		string[] spawn_args = {"ls", "-l", "-h"};
		string[] spawn_env = Environ.get ();
		Pid child_pid;

		int standard_input;
		int standard_output;
		int standard_error;

		Process.spawn_async_with_pipes ("/",
			spawn_args,
			spawn_env,
			SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
			null,
			out child_pid,
			out standard_input,
			out standard_output,
			out standard_error);

		// stdout:
		IOChannel output = new IOChannel.unix_new (standard_output);
		output.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
			return process_line (channel, condition, "stdout");
		});

		// stderr:
		IOChannel error = new IOChannel.unix_new (standard_error);
		error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
			return process_line (channel, condition, "stderr");
		});

		ChildWatch.add (child_pid, (pid, status) => {
			// Triggered when the child indicated by child_pid exits
			Process.close_pid (pid);
			loop.quit ();
		});

		loop.run ();
	} catch (SpawnError e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
