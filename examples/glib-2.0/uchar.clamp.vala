public static int main (string[] args) {
	// Output: ``j``
	uchar c = ((uchar) 'e').clamp ('j', 'o');
	stdout.printf ("%c\n", c);

	// Output: ``j``
	c = ((uchar) 'o').clamp ('e', 'j');
	stdout.printf ("%c\n", c);

	// Output: ``t``
	c = ((uchar) 't').clamp ('o', 'y');
	stdout.printf ("%c\n", c);

	return 0;
}
