public static int main (string[] args) {
	// Output: ``false``
	double val = double.INFINITY;
	print ("%s\n", val.is_normal ().to_string ());

	// Output: ``false``
	val = double.NAN;
	print ("%s\n", val.is_normal ().to_string ());

	// Output: ``true``
	val = 0.3f;
	print ("%s\n", val.is_normal ().to_string ());

	// Output: ``true``
	val = 0.3f;
	print ("%s\n", val.is_normal ().to_string ());

	// Output: ``true``
	val = 1.0f;
	print ("%s\n", val.is_normal ().to_string ());

	return 0;
}
