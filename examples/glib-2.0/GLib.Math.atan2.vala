public static int main (string[] args) {
	// Output: ``atan2 (30.000000, 20.000000) = 0.982794``
	double x = 30.0;
	double y = 20.0;
	double result = Math.atan2 (x, y);
	print("atan2 (%lf, %lf) = %lf\n", x, y, result);
	return 0;
}
