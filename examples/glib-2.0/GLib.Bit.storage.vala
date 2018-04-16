public static int main (string[] args) {
	// Output: ``3`` (4 => 100)
	uint bits = Bit.storage (4);
	print ("%u\n", bits);

	// Output: ``3`` (5 => 101)
	bits = Bit.storage (5);
	print ("%u\n", bits);

	// Output: ``4`` (8 => 1000)
	bits = Bit.storage (8);
	print ("%u\n", bits);

	return 0;
}
