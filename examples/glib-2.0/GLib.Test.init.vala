public static int main (string[] args) {
	// Use ./test --help to review our options
	Test.init (ref args);

	// Register test cases via Test.add_func & friends

	Test.run ();
	return 0;
}
