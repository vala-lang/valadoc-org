public static int main (string[] args) {
	// Output: ``12345``
	stdout.printf ("%ld\n", long.parse ("12345"));

	// Output: ``-12345``
	stdout.printf ("%ld\n", long.parse ("-12345"));

	// Output: ``0``
	stdout.printf ("%ld\n", long.parse ("d12345"));

	// Output: ``12345``
	stdout.printf ("%ld\n", long.parse ("12345D"));
	return 0;
}
