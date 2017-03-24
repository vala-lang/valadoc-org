public static int main (string[] args) {
	// Output: ``10``
	uint i = ((uint) 5).clamp (10, 15);
	print ("%u\n", i);

	// Output: ``10``
	i = ((uint) 15).clamp (5, 10);
	print ("%u\n", i);

	// Output: ``20``
	i = ((uint) 20).clamp (15, 25);
	print ("%u\n", i);

	return 0;
}
