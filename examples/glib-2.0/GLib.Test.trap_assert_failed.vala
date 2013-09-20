public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		Test.trap_subprocess ("/valadoc/driver-0.14.x/subprocess", 0, 0);

		// Assert that our subprocess failed:
		// See also: Test.trap_assert_passed ()
		Test.trap_assert_failed ();
	});

	Test.add_func ("/valadoc/driver-0.14.x/subprocess", () => {
		assert_not_reached ();
	});

	Test.run ();
	return 0;
}
