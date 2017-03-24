public static int main (string args[]) {
	// Output: ``asin (0.289000) = 0.293182``
	double x = 0.289;
	double res = Math.asin (x);
	print ("asin (%lf) = %lf\n", x, res);


	// Output: ``asin (0.000000) = 0.000000``
	x = 0;
	res = Math.asin (x);
	print ("asin (%lf) = %lf\n", x, res);


	// Output: ``asin (-2.000000) = nan``
	x = -2;
	res = Math.asin (x);
	print ("asin (%lf) = %lf\n", x, res);

	return 0;
}
