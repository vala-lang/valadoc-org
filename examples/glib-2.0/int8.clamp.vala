public static int main (string[] args) {
	// Output: ``10``
	int8 i = ((int8) 5).clamp (10, 15);
	print ("%d\n", i);

	// Output: ``10``
	i = ((int8) 15).clamp (5, 10);
	print ("%d\n", i);

	// Output: ``20``
	i = ((int8) 20).clamp (15, 25);
	print ("%d\n", i);

	return 0;
}
