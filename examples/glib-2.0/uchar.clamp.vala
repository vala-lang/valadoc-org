public static int main (string[] args) {
	// Output: ``j``
	uchar c = ((uchar) 'e').clamp ('j', 'o');
	print ("%c\n", c);

	// Output: ``j``
	c = ((uchar) 'o').clamp ('e', 'j');
	print ("%c\n", c);

	// Output: ``t``
	c = ((uchar) 't').clamp ('o', 'y');
	print ("%c\n", c);

	return 0;
}
