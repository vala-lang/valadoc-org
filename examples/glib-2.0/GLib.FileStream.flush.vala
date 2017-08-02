public static int main (string[] args) {
	// open a file:
	FileStream stream = FileStream.open ("test.txt", "w+");
	assert (stream != null);

	// write some data
	stream.puts ("some data\n");

	// make sure data is written to our file:
	stream.flush ();

	// read the data:
	stream.rewind ();
	string str = stream.read_line ();
	assert (str != null);

	print ("'%s'\n", str);

	return 0;
}
