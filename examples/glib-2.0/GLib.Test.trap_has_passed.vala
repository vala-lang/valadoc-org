public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		if (Test.trap_fork (0, TestTrapFlags.SILENCE_STDOUT | TestTrapFlags.SILENCE_STDERR)) {
			assert_not_reached ();
			Process.exit (0);
		}

		// assert_not_reached () causes the fork to fail
		//  => trap_has_passed is false!
		// See also: Test.trap_assert_passed ()
		if  (Test.trap_has_passed ()) {
			// TODO: fork succeeded
		} else {
			// fork failed
		}
	});

	Test.run ();
	return 0;
}
