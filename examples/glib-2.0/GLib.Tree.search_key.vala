public static int main (string[] args) {
	Tree<string, string> tree = new Tree<string, string> ((a, b) => { return strcmp (a, b); });
	tree.insert ("key1", "val1");
	tree.insert ("key2", "val2");
	tree.insert ("key3", "val3");

	// Output:
	//  ``visit: key2, key3``
	//  ``visit: key3, key3``
	string val = tree.search_key ((key, needle) => {
		// key: one of {"key1", "key2", "key3"}
		// needle: KEY2
		print ("visit: %s, %s\n", key, needle);

		// param order is significant!
		return strcmp (needle, key);
	}, "key3");

	// Output:
	//  ``key=KEY2, value=val3``
	print ("Selected: %s\n", val);

	return 0;
}
