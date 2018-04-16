public static int main (string[] args) {
	// Output: ``10.1235``
	print ("%g\n", double.parse ("10.12345"));

	// Output: ``-0.12345``
	print ("%g\n", double.parse ("-0.12345"));

	// Output: ``0``
	print ("%g\n", double.parse ("d.12345"));

	// Output: ``0.12345``
	print ("%g\n", double.parse ("0.12345D"));
	return 0;
}



