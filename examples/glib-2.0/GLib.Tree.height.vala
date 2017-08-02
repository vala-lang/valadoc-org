public static int main (string[] args) {
	Tree<string, string> tree = new Tree<string, string>.full ((a, b) => { return strcmp (a, b); }, free, free);
	tree.insert ("key1", "val1");
	tree.insert ("key2", "val2");
	tree.insert ("key3", "val3");
	tree.insert ("key4", "val4");

	// Output: ``Tree, height: 3``
	int height = tree.height ();
	print ("Tree, height: %d\n", height);

	return 0;
}
