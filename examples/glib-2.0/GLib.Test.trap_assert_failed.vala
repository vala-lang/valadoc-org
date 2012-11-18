public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		if (Test.trap_fork (0, TestTrapFlags.SILENCE_STDOUT | TestTrapFlags.SILENCE_STDERR)) {
			assert_not_reached ();
			Process.exit (0);
		}

		// Assert that our fork failed:
		// See also: Test.trap_assert_passed ()
		Test.trap_assert_failed ();
	});

	Test.run ();
	return 0;
}
