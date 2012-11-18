public static int main (string[] args) {
	// Output: ``10``
	uint64 i = ((uint64) 5).clamp (10, 15);
	stdout.printf ("%" + uint64.FORMAT + "\n", i);

	// Output: ``10``
	i = ((uint64) 15).clamp (5, 10);
	stdout.printf ("%" + uint64.FORMAT + "\n", i);

	// Output: ``20``
	i = ((uint64) 20).clamp (15, 25);
	stdout.printf ("%" + uint64.FORMAT + "\n", i);

	return 0;
}
