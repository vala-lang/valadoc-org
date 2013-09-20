public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		Test.trap_subprocess ("/valadoc/driver-0.14.x/subprocess", 0, 0);
		// assert_not_reached () causes the subprocess to fail
		//  => trap_has_passed is false!
		// See also: Test.trap_assert_passed ()
		if  (Test.trap_has_passed ()) {
			// ...
		} else {
			// ...
		}
	});

	Test.add_func ("/valadoc/driver-0.14.x/subprocess", () => {
		assert_not_reached ();
	});

	Test.run ();
	return 0;
}
