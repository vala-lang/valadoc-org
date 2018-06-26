public static int main (string[] args) {
	// open file:
	FileStream stream = FileStream.open ("test.txt", "w+");
	assert (stream != null);

	// write data:
	// file content: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for (char c = 'A'; c <= 'Z' ; c++) {
		stream.putc (c);
	}

	stream.flush ();

	// get the 1. char:
	//  file content: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	//  file ptr:      ^

	int tmp = stream.seek (0, FileSeek.SET);
	assert (tmp >= 0);

	int c = stream.getc ();
	assert (c >= 0);
	print ("First char: %c\n", c);

	
	// Get the next but one char:
	//  file content: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	//  file ptr:        ^

	stream.ungetc (c); // revert .getc
	tmp = stream.seek (2, FileSeek.CUR);
	assert (c >= 0);

	c = stream.getc ();
	assert (c >= 0);
	print ("Third char: %c\n", c);


	// Get the last char:
	//  file content: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	//  file ptr:                               ^

	stream.ungetc (c); // revert .getc
	tmp = stream.seek (-1, FileSeek.END);
	assert (c >= 0);

	c = stream.getc ();
	assert (c >= 0);
	print ("Last char: %c\n", c);

	return 0;
}
