public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		Test.trap_subprocess ("/valadoc/driver-0.14.x/subprocess", 0, 0);

		// Assert that our subprocess passed:
		// See also: Test.trap_assert_passed ()
		Test.trap_assert_passed ();
	});

	Test.add_func ("/valadoc/driver-0.14.x/subprocess", () => {
		int x = 3 + 2;
		assert (x == 1000);
	});

	Test.run ();
	return 0;
}
