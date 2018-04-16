public static int main (string[] args) {
	// Output: ``tanf (0.0f) = 0.000000f``
	float res = Math.tanf (0.0f);
	print ("tanf (0.0f) = %lff\n", res);

	// Output: ``tanf (0.5f) = 0.546302f``
	res = Math.tanf (0.5f);
	print ("tanf (0.5f) = %lff\n", res);

	return 0;
}
