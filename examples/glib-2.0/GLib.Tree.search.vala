public static int main (string[] args) {
	Tree<string, string> tree = new Tree<string, string>.full ((a, b) => { return strcmp (a, b); }, free, free);
	tree.insert ("key1", "val1");
	tree.insert ("key2", "val2");
	tree.insert ("key3", "val3");

	string needle = "KEY2";
	string val = tree.search ((key) => {
		// we ignore the case:
		return strcmp (needle.down (), key.down ());
	});

	// Output:
	//  ``key=KEY2, value=val2``
	print ("key=%s, val=%s\n", needle, val);

	return 0;
}
