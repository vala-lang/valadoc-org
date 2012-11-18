public static int main (string[] args) {
	// Output: ``10.1235``
	stdout.printf ("%g\n", double.parse ("10.12345"));

	// Output: ``-0.12345``
	stdout.printf ("%g\n", double.parse ("-0.12345"));

	// Output: ``0``
	stdout.printf ("%g\n", double.parse ("d.12345"));

	// Output: ``0.12345``
	stdout.printf ("%g\n", double.parse ("0.12345D"));
	return 0;
}



