public static int main (string[] args) {
	// Output: ``nan -- true``
	double val = double.NAN;
	print ("%f -- %s\n", val, val.is_nan ().to_string ());
	return 0;
}
