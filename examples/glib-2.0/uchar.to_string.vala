public static int main (string[] args) {
	// Output: ``97``
	uchar c = 'a';
	stdout.printf ("%s\n", c.to_string ());

	// Output: ``122``
	c = 'z';
	stdout.printf ("%s\n", c.to_string ());

	// Output: ``57``
	c = '9';
	stdout.printf ("%s\n", c.to_string ());

	return 0;
}
