public static int main (string[] args) {
	// Output: ``10``
	long l = 5l.clamp (10l, 15l);
	stdout.printf ("%li\n", l);

	// Output: ``10``
	l = 15l.clamp (5l, 10l);
	stdout.printf ("%li\n", l);

	// Output: ``20``
	l = 20l.clamp (15l, 25l);
	stdout.printf ("%li\n", l);

	return 0;
}
