public static int main (string[] args) {
	// Output: ``atan2f (10.000000f, 5.000000f) = 1.107149f``
	float x = 10.0f;
	float y = 05.0f;
	float result = Math.atan2f (x, y);
	print("atan2f (%lff, %lff) = %lff\n", x, y, result);
	return 0;
}
