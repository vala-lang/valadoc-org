static int main (string[] args) {
	FileStream stream = FileStream.open (args[0], "rb");
	assert (stream != null);

	stream.seek (0, FileSeek.END);
	long size = stream.tell ();

	print ("File size: %ld bytes\n", size);
	return 0;
}
