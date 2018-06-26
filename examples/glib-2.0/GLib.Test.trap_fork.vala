public static int main (string[] args) {
	Test.init (ref args);
 	Test.bug_base ("http://bugzilla.gnome.org/");

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		// start a fork & reduce its runtime to 9000 micro seconds
		if (Test.trap_fork (9000, TestTrapFlags.SILENCE_STDOUT | TestTrapFlags.SILENCE_STDERR)) {
			// Simulate driver output:
			print ("warning: unexpected token: ==\n");
			stderr.printf ("error: unexpected token: ==\n");

			// use assert () and friends to verify your code
			// assert (false) marks a test as "not-passed"

			// Make sure the fork exists at the end of our test case:
			Process.exit (0);
		}


		//
		// Optional checks & asserts:
		//

		// Check whether the last fork passed/succeeded:
		if (Test.trap_has_passed ()) {
			// Whatever
		}


		// Check whether GTest killed the fork due to a timeout
		if (Test.trap_reached_timeout ()) {
			Test.message ("timeout reached!!");
		}


		// Make sure the last forked test passed/succeeded:
		Test.trap_assert_passed ();


		// Make sure the forked output does match the following patterns:
		// See GLib.PatternSpec for details
		Test.trap_assert_stdout ("*warning:*");
		Test.trap_assert_stderr ("*error:*");


		// Make sure the forked output does not match the following patterns:
		Test.trap_assert_stdout_unmatched ("*debug:*");
		Test.trap_assert_stderr_unmatched ("*critical-error:*");
	});

	Test.run ();
	return 0;
}
