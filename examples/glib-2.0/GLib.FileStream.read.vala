public static int main (string[] args) {
	// open file stream:
	FileStream stream = FileStream.open ("GLib.FileStream.read.vala", "r");
	assert (stream != null);

	// get file size:
	stream.seek (0, FileSeek.END);
	long size = stream.tell ();
	stream.rewind ();

	// load content:
	uint8[] buf = new uint8[size];
	size_t read = stream.read (buf, 1);
	assert (size == read);

	// display content:
	print ((string) buf);	

	return 0;
}
