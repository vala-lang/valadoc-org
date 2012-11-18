public static int main (string[] args) {
	// Opens "foo.txt" for reading ("r")
	FileStream stream = FileStream.open ("filestream.vala", "r");
	assert (stream != null);

	// Char by char:
	int c = 0;
	while ((c = stream.getc ()) >= 0) {
		stdout.putc ((char) c);
	}

	return 0;
}

