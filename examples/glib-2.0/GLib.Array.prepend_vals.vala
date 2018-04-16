public int main (string[] args) {
	Array<unowned string> array = new Array<unowned string> ();
	array.prepend_val ("3. entry");

	string[] data = {"1. entry", "2. entry"};
	array.prepend_vals (data, data.length);

	// Output:
	//  ``1. entry``
	//  ``2. entry``
	//  ``3. entry``
	for (int i = 0; i < array.length ; i++) {
		print ("%s\n", array.index (i));
	}

	return 0;
}
