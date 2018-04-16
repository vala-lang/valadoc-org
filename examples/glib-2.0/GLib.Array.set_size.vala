public int main (string[] args) {
	Array<string> array = new Array<string> ();
	array.set_size (2);				// [null, null]
	array.append_val ("3. entry");	// [null, null, 3]
	array.append_val ("4. entry");	// [null, null, 3, 4]

	// Output:
	//  ``(null)``
	//  ``(null)``
	//  ``3. entry``
	//  ``4. entry``
	for (int i = 0; i < array.length ; i++) {
		print ("%s\n", array.index (i));
	}

	return 0;
}
