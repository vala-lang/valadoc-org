public static int main (string[] args) {
	Test.init (ref args);

	// Add some random test cases:
	Test.add_func ("/libvaladoc/driver-0.12.x", () => {
		// TODO: test
		Test.fail ();
	});
	Test.add_func ("/libvaladoc/driver-0.12.x", () => {
		// TODO: test
	});
	Test.add_func ("/libvaladoc/driver-0.12.x", () => {
		// TODO: test
	});

	// Run all tests!
	return Test.run ();
}
