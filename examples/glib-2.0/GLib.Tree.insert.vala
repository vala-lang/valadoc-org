public static int main (string[] args) {
	Tree<string, string> tree = new Tree<string, string>.full ((a, b) => { return strcmp (a, b); }, free, free);
	tree.insert ("key1", "val1");
	tree.insert ("key2", "val2");
	tree.insert ("key3", "val3");
	tree.insert ("key3", "val3");

	// Output:
	//  ``key=key1, value=val1``
	//  ``key=key2, value=val2``
	//  ``key=key3, value=val3``
	tree.@foreach ((key, val) => {
		print ("key=%s, value=%s\n", (string) key, (string) val);
		return false;
	});

	return 0;
}
