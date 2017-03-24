public static int main (string[] args) {
	char[] data = new char[10];
	Memory.set (data, '=', sizeof(char) * data.length);
	// Output: ``==========``
	foreach (char i in data) {
		stdout.putc (i);
	}
	print ("\n");
	return 0;
}
