public int main (string[] args) {
	Array<string> array = new Array<string> ();
	array.append_val ("1. entry");
	array.append_val ("2. entry");
	array.append_val ("3. entry");
	array.append_val ("4. entry");

	array.remove_index_fast (1);

	// Output:
	//  ``1. entry``
	//  ``4. entry``  4 was the last element!
	//  ``3. entry``
	for (int i = 0; i < array.length ; i++) {
		print ("%s\n", array.index (i));
	}

	return 0;
}
