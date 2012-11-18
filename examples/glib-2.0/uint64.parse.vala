public static int main (string[] args) {
	// Output: ``12345``
	stdout.printf ("%" + uint64.FORMAT + "\n", uint64.parse ("12345"));

	// Output: ``18446744073709539271``
	stdout.printf ("%" + uint64.FORMAT + "\n", uint64.parse ("-12345"));

	// Output: ``0``
	stdout.printf ("%" + uint64.FORMAT + "\n", uint64.parse ("d12345"));

	// Output: ``12345``
	stdout.printf ("%" + uint64.FORMAT + "\n", uint64.parse ("12345D"));
	return 0;
}
