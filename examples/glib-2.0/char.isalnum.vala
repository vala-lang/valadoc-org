public static int main (string[] args) {
	// Output:
	//  ``'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ``
	//  ``'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', ``
	//  ``'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', ``
	//  ``'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', ``
	//  ``'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', ``
	//  ``'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', ``
	//  ``'y', 'z', ``

	for (int i = 0; i <= 255; i++) {
		if (((char) i).isalnum () == true) {
			print ("'%c', ", (char) i);
		}
	}
	print ("\n");
	return 0;
}
