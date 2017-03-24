public int main (string[] args) {
	Array<unowned string> array = new Array<unowned string> ();
	string[] data = {"1. entry", "2. entry", "3. entry"};

	// we only copy ptrs but not the strings!
	array.append_vals (data, data.length);

	// Output:
	//  ``1. entry``
	//  ``2. entry``
	//  ``3. entry``
	for (int i = 0; i < array.length ; i++) {
		print ("%s\n", array.index (i));
	}

	return 0;
}
