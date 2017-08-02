public static int main (string[] args) {
	// Output: ``sinf (0.0f) = 0.000000f``
	float res = Math.sinf (0.0f);
	print ("sinf (0.0f) = %lff\n", res);

	// Output: ``sinf (0.5f) = 0.479426f``
	res = Math.sinf (0.5f);
	print ("sinf (0.5f) = %lff\n", res);

	return 0;
}
