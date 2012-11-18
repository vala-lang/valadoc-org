static int main (string[] args) {
	FileStream stream = FileStream.open ("test.bin", "ab");
	assert (stream != null);

	// write binary data to test.bin:
	uint8[] buf = { 'a', 'b', 'c' };
	stream.write (buf, buf.length);
	return 0;
}
