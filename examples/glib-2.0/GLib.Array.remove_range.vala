public int main (string[] args) {
	Array<string> array = new Array<string> ();
	array.append_val ("1. entry");
	array.append_val ("x. xxxxx");
	array.append_val ("x. xxxxx");
	array.append_val ("x. xxxxx");
	array.append_val ("2. entry");
	array.append_val ("3. entry");

	// [1, x, x, x, 2, 3]
	//     ^ ----/
	//     1, 3 items
	array.remove_range (1, 3);

	// Output:
	//  ``1. entry``
	//  ``4. entry``  4 was the last element!
	//  ``3. entry``
	for (int i = 0; i < array.length ; i++) {
		print ("%s\n", array.index (i));
	}

	return 0;
}
