public static int main (string[] args) {
	FileStream stream = FileStream.open (args[0], "rb");
	assert (stream != null);
	int cnt = 0;

	for (cnt = 0; stream.eof () == false; stream.getc (), cnt++);
	print ("%d\n", cnt);

	return 0;
}
