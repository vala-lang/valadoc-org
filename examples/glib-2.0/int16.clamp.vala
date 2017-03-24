public static int main (string[] args) {
	// Output: ``10``
	int16 i = ((int16) 5).clamp (10, 15);
	print ("%d\n", i);

	// Output: ``10``
	i = ((int16) 15).clamp (5, 10);
	print ("%d\n", i);

	// Output: ``20``
	i = ((int16) 20).clamp (15, 25);
	print ("%d\n", i);

	return 0;
}
