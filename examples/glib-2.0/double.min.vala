public static int main (string[] args) {
	// Output: ``min (0.1f, 0.9f) = 0.1``
	double min = double.min (0.1, 0.9);
	stdout.printf ("min (0.1, 0.9) = %g\n", min);
	return 0;
}
