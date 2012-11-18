public static int main (string[] args) {
	// open an existing file for reading:
	FileStream stream = FileStream.open ("test.txt", "r");
	assert (stream != null);

	// trigger an error by writing:
	// Output: ``Error!``
	stream.puts ("data");
	if (stream.error () != 0) {
		stdout.printf ("Error!\n");
	}

	return 0;
}
