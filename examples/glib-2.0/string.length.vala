public static int main (string[] args) {
	string str = "Ἀρχιμήδης";
	int letters = str.char_count ();
	int bytes = str.length;

	// Output: ``letters: 9, bytes: 19``
	stdout.printf ("letters: %d, bytes: %d\n", letters, bytes);
	return 0;
}
