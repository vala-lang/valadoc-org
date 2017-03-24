public static int main (string[] args) {
	// Output: ``10``
	size_t l = ((size_t) 5l).clamp (10, 15);
	print ("%lu\n", l);

	// Output: ``10``
	l = ((size_t) 15).clamp (5, 10);
	print ("%lu\n", l);

	// Output: ``20``
	l = ((size_t) 20).clamp (15, 25);
	print ("%lu\n", l);

	return 0;
}
