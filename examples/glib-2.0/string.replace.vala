public static int main (string[] args) {
	// Output: ``An apple a day keeps the TARDIS away``
	string res = "An apple a day keeps the doctor away".replace ("doctor", "TARDIS");
	stdout.printf ("%s\n", res);
	return 0;
}
