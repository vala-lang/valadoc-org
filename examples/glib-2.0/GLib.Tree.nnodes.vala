public static int main (string[] args) {
	Tree<string, string> tree = new Tree<string, string>.full ((a, b) => { return strcmp (a, b); }, free, free);
	tree.insert ("key1", "val1");
	tree.insert ("key2", "val2");
	tree.insert ("key3", "val3");

	// Output: ``nodes: 3``
	int cnt = tree.nnodes ();
	print ("nodes: %d\n", cnt);

	return 0;
}
