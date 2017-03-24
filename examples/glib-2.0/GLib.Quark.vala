public static int main (string[] args) {
	// ** from_string:

	// Register a new string: Output: ``51``
	Quark q = Quark.from_string ("my-test-str-1");
	print ("my-test-str: %u\n", q);

	// Get the registered quark: Output: ``51``
	q = Quark.from_string ("my-test-str-1");
	print ("my-test-str: %u\n", q);


	// ** try_string:

	// Known string: Output: ``51``
	q = Quark.try_string ("my-test-str-1");
	print ("my-test-str: %u\n", q);

	// Unknown string: Output: ``0``
	q = Quark.try_string ("my-test-str-UNKNOWN");
	print ("my-test-str: %u\n", q);

	return 0;
}
