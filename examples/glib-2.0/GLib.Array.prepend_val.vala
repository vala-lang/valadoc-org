public int main (string[] args) {
	Array<string> array = new Array<string> ();
	array.prepend_val ("3. entry");
	array.prepend_val ("2. entry");
	array.prepend_val ("1. entry");

	// Output:
	//  ``1. entry``
	//  ``2. entry``
	//  ``3. entry``
	for (int i = 0; i < array.length ; i++) {
		stdout.printf ("%s\n", array.index (i));
	}

	return 0;
}
