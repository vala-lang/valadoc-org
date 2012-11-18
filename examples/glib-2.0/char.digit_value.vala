public static int main (string[] args) {
	// Output: ``'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ``
	for (int i = 0; i <= 255; i++) {
		if (((char) i).digit_value () >= 0) {
			stdout.printf ("'%c', ", (char) i);
		}
	}
	stdout.putc ('\n');
	return 0;
}
