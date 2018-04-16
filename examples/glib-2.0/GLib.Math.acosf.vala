public static int main (string[] args) {
	// Output: ``acosf (0.500000f) = 1.047198f``
	float x = 0.5f;
	float res = Math.acosf (x);
	print("acosf (%lff) = %lff\n", x, res);


	// Output: ``acosf (1.000000f) = 0.000000f``
	x = 1;
	res = Math.acosf (x);
	print("acosf (%lff) = %lff\n", x, res);


	// Output: ``acosf (2.000000f) = nanf``
	x = 2;
	res = Math.acosf (x);
	print("acosf (%lff) = %lff\n", x, res);

	return 0;
}
