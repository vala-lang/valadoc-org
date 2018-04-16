public static int main (string[] args) {
	// Opens "foo.txt" for reading ("r")
	FileStream stream = FileStream.open ("filestream.vala", "r");
	assert (stream != null);

	string? line = null;
	while ((line = stream.read_line ()) != null) {
		print (line);
		print ("\n");
	}

	return 0;
}
