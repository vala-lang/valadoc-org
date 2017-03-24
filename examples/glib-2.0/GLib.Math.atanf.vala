public static int main (string[] args) {
	// Output: ``atanf (0.632500) = 0.563974``
	float x = 0.6325f;
	float result = Math.atanf (x);
	print ("atanf (%lf) = %lf\n", x, result);

	// Output: ``atanf (0.000000) = 0.000000``
	x = 0;
	result = Math.atanf (x);
	print ("atanf (%lf) = %lf\n", x, result);

	return 0;
}
