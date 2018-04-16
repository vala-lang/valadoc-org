public static int main (string[] args) {
	Checksum checksum = new Checksum (ChecksumType.MD5);

	FileStream stream = FileStream.open (args[0], "rb");
	uint8 fbuf[100];
	size_t size;

	while ((size = stream.read (fbuf)) > 0) {
		checksum.update (fbuf, size);
	}

	unowned string digest = checksum.get_string ();
	print ("%s: %s\n", args[0], digest);
	return 0;
}
