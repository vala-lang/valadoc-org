public static int main (string[] args) {
	// Output:
	//  ``'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', ``
	//  ``'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', ``
	//  ``'w', 'x', 'y', 'z', ``

	for (int i = 0; i <= 255; i++) {
		if (((char) i).islower () == true) {
			print ("'%c', ", (char) i);
		}
	}
	print ("\n");
	return 0;
}
