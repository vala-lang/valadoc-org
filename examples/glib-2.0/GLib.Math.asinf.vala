public static int main (string args[]) {
	// Output: ``asinf (0.289000f) = 0.293182f``
	float x = 0.289f;
	float res = Math.asinf (x);
	print ("asinf (%lff) = %lff\n", x, res);


	// Output: ``asinf (0.000000f) = 0.000000f``
	x = 0;
	res = Math.asinf (x);
	print ("asinf (%lff) = %lff\n", x, res);


	// Output: ``asinf (-2.000000f) = nanf``
	x = -2;
	res = Math.asinf (x);
	print ("asinf (%lff) = %lff\n", x, res);

	return 0;
}
