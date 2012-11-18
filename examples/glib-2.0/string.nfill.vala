public static int main (string[] args) {
	// Output: ``zzzzzzzzzz``
	string str = string.nfill (10, 'z');
	stdout.printf ("%s\n", str);
	return 0;
}
