public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/libvaladoc/driver-0.12.x", () => {
		// TODO: test
	});

	Test.run ();
	return 0;
}
