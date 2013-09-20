public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		Test.trap_subprocess ("/valadoc/driver-0.14.x/subprocess", 0, 0);
		Test.trap_assert_passed ();

		// Assert that the stderr output does not match the pattern:
		// See GLib.PatternSpec for details
		Test.trap_assert_stderr_unmatched ("*error:*");
	});

	Test.add_func ("/valadoc/driver-0.14.x/subprocess", () => {
		stderr.printf ("warning: unexpected token: ==\n");
	});

	Test.run ();
	return 0;
}
