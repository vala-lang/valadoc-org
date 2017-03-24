public static int main (string[] args) {
	// Opens "foo.txt" for reading ("r")
	FileStream stream = FileStream.open ("filestream.vala", "r");
	assert (stream != null);

	// buffered:
	char buf[100];
	while (stream.gets (buf) != null) {
		print ((string) buf);
	}

	return 0;
}
