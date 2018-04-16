public static int main (string[] args) {
	// Output: ``0.150000``
	float f = 0.5f.clamp (0.10f, 0.15f);
	print ("%f\n", f);

	// Output: ``0.100000``
	f = 0.15f.clamp (0.5f, 0.10f);
	print ("%f\n", f);

	// Output: ``0.200000``
	f = 0.20f.clamp (0.15f, 0.25f);
	print ("%f\n", f);

	return 0;
}
