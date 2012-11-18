public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		if (Test.trap_fork (0, TestTrapFlags.SILENCE_STDOUT | TestTrapFlags.SILENCE_STDERR)) {
			// Simulate driver output:
			stdout.printf ("warning: unexpected token: ==\n");

			// Make sure the fork exists at the end of our test case:
			Process.exit (0);
		}

		// Make sure the forked output does match the following pattern:
		// See GLib.PatternSpec for details
		Test.trap_assert_stdout_unmatched ("*error:*");
	});

	Test.run ();
	return 0;
}
