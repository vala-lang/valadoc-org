public static int main (string[] args) {
	// Output: ``j``
	char c = 'e'.clamp ('j', 'o');
	print ("%c\n", c);

	// Output: ``j``
	c = 'o'.clamp ('e', 'j');
	print ("%c\n", c);

	// Output: ``t``
	c = 't'.clamp ('o', 'y');
	print ("%c\n", c);

	return 0;
}
