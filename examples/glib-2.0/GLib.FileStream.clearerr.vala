public static int main (string[] args) {
	// open an existing file for reading:
	FileStream stream = FileStream.open ("test.txt", "r");
	assert (stream != null);

	// trigger an error by writing:
	stream.puts ("data");
	assert (stream.error () != 0);

	// resets error, eof:
	stream.clearerr ();

	// Continue

	return 0;
}
