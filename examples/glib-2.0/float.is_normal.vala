public static int main (string[] args) {
	// Output: ``false``
	float val = float.INFINITY;
	print ("%s\n", val.is_normal ().to_string ());

	// Output: ``false``
	val = float.NAN;
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
