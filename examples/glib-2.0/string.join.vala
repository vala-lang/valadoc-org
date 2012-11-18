public static int main (string[] args) {
	// Output: ``Dalek, Cyberman, Weeping Angel``
	string enemies = string.join (", ", "Dalek", "Cyberman", "Weeping Angel");
	stdout.printf ("%s\n", enemies);
	return 0;
}
