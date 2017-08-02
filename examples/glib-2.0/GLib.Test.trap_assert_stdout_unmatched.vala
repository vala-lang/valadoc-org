public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		Test.trap_subprocess ("/valadoc/driver-0.14.x/subprocess", 0, 0);
		Test.trap_assert_passed ();

		// Assert that the stdout output does not match the pattern:
		// See GLib.PatternSpec for details
		Test.trap_assert_stdout_unmatched ("*error:*");
	});

	Test.add_func ("/valadoc/driver-0.14.x/subprocess", () => {
		print ("warning: unexpected token: ==\n");
	});

	Test.run ();
	return 0;
}
