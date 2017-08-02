public static int main (string[] args) {
	// Output: ``0.150000``
	double d = 0.5.clamp (0.10, 0.15);
	print ("%f\n", d);

	// Output: ``0.100000``
	d = 0.15.clamp (0.5, 0.10);
	print ("%f\n", d);

	// Output: ``0.200000``
	d = 0.20.clamp (0.15, 0.25);
	print ("%f\n", d);

	return 0;
}
