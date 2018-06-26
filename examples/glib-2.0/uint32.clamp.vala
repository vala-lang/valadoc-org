public static int main (string[] args) {
	// Output: ``10``
	uint32 i = ((uint32) 5).clamp (10, 15);
	print ("%u\n", i);

	// Output: ``10``
	i = ((uint32) 15).clamp (5, 10);
	print ("%u\n", i);

	// Output: ``20``
	i = ((uint32) 20).clamp (15, 25);
	print ("%u\n", i);

	return 0;
}
