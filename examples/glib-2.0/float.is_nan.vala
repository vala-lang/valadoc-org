public static int main (string[] args) {
	float f1 = -1.1f;
	float f2 = 1.1f;
	float f3 = float.NAN;
	float f4 = Math.sinf (float.INFINITY); // domain error

	// Output: ``false``
	stdout.printf ("%s\n", f1.is_nan ().to_string ());
	// Output: ``false``
	stdout.printf ("%s\n", f2.is_nan ().to_string ());
	// Output: ``true``
	stdout.printf ("%s\n", f3.is_nan ().to_string ());
	// Output: ``true``
	stdout.printf ("%s\n", f4.is_nan ().to_string ());

	return 0;
}
