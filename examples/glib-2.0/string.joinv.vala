public static int main (string[] args) {
	// Output: ``Dalek, Cyberman, Weeping Angel``
	string[] enemy_list = {"Dalek", "Cyberman", "Weeping Angel"};
	string enemies = string.joinv (", ", enemy_list);
	stdout.printf ("%s\n", enemies);
	return 0;
}
