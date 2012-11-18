public static int main (string[] args) {
	// Output:
	//  ``'\t', '\r', '\n', ' '``

	for (int i = 0; i <= 255; i++) {
		if (((char) i).isspace () == true) {
			stdout.printf ("'%c', ", (char) i);
		}
	}
	stdout.putc ('\n');
	return 0;
}
