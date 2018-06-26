public static int main (string[] args) {
	// Output:
	//  ``'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ``
	//  ``'A', 'B', 'C', 'D', 'E', 'F', 'a', 'b', 'c', 'd', ``
	//  ``'e', 'f', ``

	for (int i = 0; i <= 255; i++) {
		if (((char) i).isxdigit () == true) {
			print ("'%c', ", (char) i);
		}
	}
    print ("\n");
	return 0;
}
