public static int main (string[] args) {
	MainLoop loop = new MainLoop (null, false);
	IOChannel channel = null;

	try {
		channel = new IOChannel.file ("my-io-channel-test-file.txt", "r");
	} catch (FileError e) {
		stdout.printf ("FileError: %s\n", e.message);
		return 0;
	}

	uint stat = channel.add_watch (IOCondition.IN, (source, condition) => {
		size_t terminator_pos = -1;
		string str_return = null;
		size_t length = -1;

		if (condition == IOCondition.HUP) {
			stdout.printf ("The connection has been broken.\n");
			return false;
		}

		try {
			IOStatus status = channel.read_line (out str_return, out length, out terminator_pos);
			if (status == IOStatus.EOF) {
				// Quit the program:
				loop.quit ();
				return false;
			}

			stdout.printf ("watch: %s", str_return);
			return true;
		} catch (IOChannelError e) {
			stdout.printf ("IOChannelError: %s\n", e.message);
			return false;
		} catch (ConvertError e) {
			stdout.printf ("ConvertError: %s\n", e.message);
			return false;
		}
	});

	if(stat == 0) {
		stdout.printf ("Cannot add watch on IOChannel.\n");
		return 0;
	}

	loop.run ();
	return 0;
}

