public static int main (string[] args) {
	// Output: ``10``
	ssize_t l = ((ssize_t) 5l).clamp (10, 15);
	stdout.printf ("%lu\n", l);

	// Output: ``10``
	l = ((ssize_t) 15).clamp (5, 10);
	stdout.printf ("%lu\n", l);

	// Output: ``20``
	l = ((ssize_t) 20).clamp (15, 25);
	stdout.printf ("%lu\n", l);

	return 0;
}
