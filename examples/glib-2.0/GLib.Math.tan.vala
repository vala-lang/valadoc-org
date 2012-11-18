public static int main (string[] args) {
	// Output: ``tan (0.0) = 0.000000``
	double res = Math.tan (0.0);
	stdout.printf ("tan (0.0) = %lf\n", res);

	// Output: ``tan (0.5) = 0.546302``
	res = Math.tan (0.5);
	stdout.printf ("tan (0.5) = %lf\n", res);

	return 0;
}
