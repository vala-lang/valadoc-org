public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		// Mark test case as failed
		Test.fail ();

		// Test case is still running until we return / exit:
		message ("still running");
	});

	Test.run ();
	return 0;
}
