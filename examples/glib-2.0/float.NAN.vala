public static int main (string[] args) {
	// Output: ``nan -- true``
	float val = float.NAN;
	print ("%f -- %s\n", val, val.is_nan ().to_string ());
	return 0;
}
