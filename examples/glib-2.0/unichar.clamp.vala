public static int main (string[] args) {
	// Output: ``j``
	unichar c = ((unichar) 'e').clamp ('j', 'o');
	stdout.printf ("%s\n", c.to_string ());

	// Output: ``j``
	c = ((unichar) 'o').clamp ('e', 'j');
	stdout.printf ("%s\n", c.to_string ());

	// Output: ``t``
	c = ((unichar) 't').clamp ('o', 'y');
	stdout.printf ("%s\n", c.to_string ());

	return 0;
}
