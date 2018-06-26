public static int main (string[] args) {
	// Output:
	//  ``'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', ``
	//  ``'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', ``
	//  ``'W', 'X', 'Y', 'Z', ``

	for (int i = 0; i <= 255; i++) {
		if (((char) i).isupper () == true) {
			print ("'%c', ", (char) i);
		}
	}
	print ("\n");
	return 0;
}
