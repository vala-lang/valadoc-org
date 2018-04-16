public static int main (string[] args) {
	// Output: ``atan (0.632500) = 0.563974``
	double x = 0.6325;
	double result = Math.atan (x);
	print ("atan (%lf) = %lf\n", x, result);

	// Output: ``atan (0.000000) = 0.000000``
	x = 0;
	result = Math.atan (x);
	print ("atan (%lf) = %lf\n", x, result);

	// Output: ``atan (1.570796) = 1.003885``
	x = Math.PI / 2;
	result = Math.atan (x);
	print ("atan (%lf) = %lf\n", x, result);
	return 0;
}
