public static int main (string[] args) {
	Tree<string, string> tree = new Tree<string, string>.full ((a, b) => { return strcmp (a, b); }, free, free);
	tree.insert ("key1", "val1");
	tree.insert ("key2", "val2");
	tree.insert ("key3", "val3");

	// Output: ``value=val2``
	string val = tree.lookup ("key2");
	stdout.printf ("value=%s\n", val);

	return 0;
}
