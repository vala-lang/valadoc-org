public int main (string[] args) {
	Array<unowned string> array = new Array<unowned string> ();
	string entry1 = "1. entry";
	array.append_val (entry1);

	// we only copy ptrs but not the strings!
	string[] data = {"2. entry", "3. entry"};
	array.insert_vals (1, data, data.length);

	// Output:
	//  ``1. entry``
	//  ``2. entry``
	//  ``3. entry``
	for (int i = 0; i < array.length ; i++) {
		print ("%s\n", array.index (i));
	}

	return 0;
}
