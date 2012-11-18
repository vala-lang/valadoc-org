public static int main (string[] args) {
	// Output: ``10``
	ulong l = ((ulong) 5l).clamp (10, 15);
	stdout.printf ("%lu\n", l);

	// Output: ``10``
	l = ((ulong) 15).clamp (5, 10);
	stdout.printf ("%lu\n", l);

	// Output: ``20``
	l = ((ulong) 20).clamp (15, 25);
	stdout.printf ("%lu\n", l);

	return 0;
}
