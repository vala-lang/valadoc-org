public static int main (string[] args) {
	// Output: ``'my str'``
	string quote = Shell.quote ("my str");
	stdout.printf ("%s\n", quote);
	return 0;
}
