public static int main (string[] args) {
	double d1 = -1.1;
	double d2 = 1.1;
	double d3 = double.NAN;
	double d4 = Math.sin (double.INFINITY); // domain error

	// Output: ``false``
	stdout.printf ("%s\n", d1.is_nan ().to_string ());
	// Output: ``false``
	stdout.printf ("%s\n", d2.is_nan ().to_string ());
	// Output: ``true``
	stdout.printf ("%s\n", d3.is_nan ().to_string ());
	// Output: ``true``
	stdout.printf ("%s\n", d4.is_nan ().to_string ());

	return 0;
}
