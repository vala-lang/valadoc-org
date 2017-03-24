public static int main (string[] args) {
	// Output: ``'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ``
	for (int i = 0; i <= 255; i++) {
		if (((char) i).isdigit () == true) {
			print ("'%c', ", (char) i);
		}
	}
	print ("\n");
	return 0;
}
