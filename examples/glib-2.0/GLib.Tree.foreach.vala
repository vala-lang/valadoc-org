public static int main (string[] args) {
	Tree<string, string> tree = new Tree<string, string>.full ((a, b) => { return strcmp (a, b); }, free, free);
	tree.insert ("key1", "val1");
	tree.insert ("key2", "val2");
	tree.insert ("key3", "val3");

	// Output:
	//  ``key=key1, value=val1``
	//  ``key=key2, value=val2``
	//  ``key=key3, value=val3``
	tree.@foreach ((_key, _val) => {
		unowned string key = (string) _key; // void* _key
		unowned string val = (string) _val; // void* _val
		print ("key=%s, value=%s\n", key, val);
		return false; // return true to stop foreach
	});

	return 0;
}
