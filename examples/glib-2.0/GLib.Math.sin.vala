public static int main (string[] args) {
	// Output: ``sin (0.0) = 0.000000``
	double res = Math.sin (0.0);
	stdout.printf ("sin (0.0) = %lf\n", res);

	// Output: ``sin (0.5) = 0.479426``
	res = Math.sin (0.5);
	stdout.printf ("sin (0.5) = %lf\n", res);

	return 0;
}
