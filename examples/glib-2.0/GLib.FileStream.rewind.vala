public static int main (string[] args) {
	FileStream stream = FileStream.open ("test.txt", "w");
	assert (stream != null);

	// file content: "AAAAAAAA"
	stream.puts ("AAAAAAAA\n");

	// move the file pos back to 0:
	stream.rewind ();

	// overwrite the first 4 chars:
	stream.puts ("BBBB");

	// file content: ``BBBBAAAA``
	return 0;
}
