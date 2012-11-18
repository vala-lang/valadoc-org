public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		if (Test.trap_fork (900, TestTrapFlags.SILENCE_STDOUT | TestTrapFlags.SILENCE_STDERR)) {
			// Force GTest to kill this fork due to a timeout:
			Thread.usleep (1000);
			Process.exit (0);
		}

		// Test.trap_reached_timeout () = true:
		if (Test.trap_reached_timeout ()) {
			Test.message ("timeout reached!!");
		} else {
			Test.message ("timeout not reached!");
		}
	});

	Test.run ();
	return 0;
}
