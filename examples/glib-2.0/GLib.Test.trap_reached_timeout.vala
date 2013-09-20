public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		// Force GTest to kill the subprocess after 900 micro seconds:
		Test.trap_subprocess ("/valadoc/driver-0.14.x/subprocess", 1000*5, 0);

		// Test.trap_reached_timeout () = true:
		if (!Test.trap_reached_timeout ()) {
			Test.message ("timeout reached!");
			Test.fail ();
		} else {
			Test.message ("timeout not reached!");
		}
	});

	Test.add_func ("/valadoc/driver-0.14.x/subprocess", () => {
		while (true) {
			Thread.usleep (100);
		}
	});

	Test.run ();
	return 0;
}
