public static int main (string[] args) {
	MainLoop loop = new MainLoop (null, false);
	IOChannel channel = null;

	try {
		channel = new IOChannel.file ("my-io-channel-test-file.txt", "r");
	} catch (FileError e) {
		print ("FileError: %s\n", e.message);
		return 0;
	}

	uint stat = channel.add_watch (IOCondition.IN, (source, condition) => {
		size_t terminator_pos = -1;
		string str_return = null;
		size_t length = -1;

		if (condition == IOCondition.HUP) {
			print ("The connection has been broken.\n");
			return false;
		}

		try {
			IOStatus status = channel.read_line (out str_return, out length, out terminator_pos);
			if (status == IOStatus.EOF) {
				// Quit the program:
				loop.quit ();
				return false;
			}

			print ("watch: %s", str_return);
			return true;
		} catch (IOChannelError e) {
			print ("IOChannelError: %s\n", e.message);
			return false;
		} catch (ConvertError e) {
			print ("ConvertError: %s\n", e.message);
			return false;
		}
	});

	if(stat == 0) {
		print ("Cannot add watch on IOChannel.\n");
		return 0;
	}

	loop.run ();
	return 0;
}

