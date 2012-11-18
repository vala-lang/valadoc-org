public static int main (string[] args) {
	// Output: ``j``
	char c = 'e'.clamp ('j', 'o');
	stdout.printf ("%c\n", c);

	// Output: ``j``
	c = 'o'.clamp ('e', 'j');
	stdout.printf ("%c\n", c);

	// Output: ``t``
	c = 't'.clamp ('o', 'y');
	stdout.printf ("%c\n", c);

	return 0;
}
