public static int main (string[] args) {
	// Output: ``20``
	char[] buf = new char[double.DTOSTR_BUF_SIZE];
	unowned string str = (20.0).to_str (buf);
	print ("%s\n", str);
	return 0;
}
