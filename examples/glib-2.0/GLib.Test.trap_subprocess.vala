public static int main (string[] args) {
	Test.init (ref args);
	Test.bug_base ("http://bugzilla.gnome.org/");


	Test.add_func ("/valadoc/driver-0.14.x", () => {
		Test.trap_subprocess ("/valadoc/driver-0.14.x/subprocess", 0, 0);

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

	// Because of the '/subprocess' in the name, this test will
	// not be run by the Test.run () call below.
	Test.add_func ("/valadoc/driver-0.14.x/subprocess", () => {
		// Our testcase:
		// ...
		print ("warning: unexpected token: ==\n");
		stderr.printf ("error: unexpected token: ==\n");
		// ..

		// use assert () and friends to verify your code
		// assert (false) marks a test as "not-passed"
	});

	Test.run ();
	return 0;
}
