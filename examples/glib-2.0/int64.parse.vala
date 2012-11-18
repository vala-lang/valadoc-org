public static int main (string[] args) {
	// Output: ``12345``
	stdout.printf ("%" + int64.FORMAT + "\n", int64.parse ("12345"));

	// Output: ``-12345``
	stdout.printf ("%" + int64.FORMAT + "\n", int64.parse ("-12345"));

	// Output: ``0``
	stdout.printf ("%" + int64.FORMAT + "\n", int64.parse ("d12345"));

	// Output: ``12345``
	stdout.printf ("%" + int64.FORMAT + "\n", int64.parse ("12345D"));
	return 0;
}
