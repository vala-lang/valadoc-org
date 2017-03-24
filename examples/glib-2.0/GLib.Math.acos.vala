public static int main (string[] args) {
	// Output: ``acos (0.500000) = 1.047198``
	double x = 0.5;
	double res = Math.acos (x);
	print("acos (%lf) = %lf\n", x, res);


	// Output: ``acos (1.000000) = 0.000000``
	x = 1;
	res = Math.acos (x);
	print("acos (%lf) = %lf\n", x, res);


	// Output: ``acos (2.000000) = nan``
	x = 2;
	res = Math.acos (x);
	print("acos (%lf) = %lf\n", x, res);

	return 0;
}
