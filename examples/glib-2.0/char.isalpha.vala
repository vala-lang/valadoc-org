public static int main (string[] args) {
	// Output:
	//  ``'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', ``
	//  ``'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', ``
	//  ``'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', ``
	//  ``'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', ``
	//  ``'w', 'x', 'y', 'z', ``

	for (int i = 0; i <= 255; i++) {
		if (((char) i).isalpha () == true) {
			print ("'%c', ", (char) i);
		}
	}
	print ("\n");
	return 0;
}
