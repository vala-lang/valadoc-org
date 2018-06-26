public static int main (string[] args) {
	// Output:
	//  ``'\t', '\r', '\n', ' '``

	for (int i = 0; i <= 255; i++) {
		if (((char) i).isspace () == true) {
			print ("'%c', ", (char) i);
		}
	}
	print ("\n");
	return 0;
}
