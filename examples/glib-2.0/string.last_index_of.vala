public static int main (string[] args) {
	string str = "/this/is/my/file.en.txt";
	int i = str.last_index_of (".");

	// Output: ``txt``
	stdout.printf ("%s\n", str.substring (i + 1));
	return 0;
}
