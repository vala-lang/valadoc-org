public int main (string[] args) {
	Array<string> array = new Array<string> ();
	array.append_val ("1. entry");
	array.append_val ("2. entry");
	array.append_val ("3. entry");

	// Output:
	//  ``1. entry``
	//  ``2. entry``
	//  ``3. entry``
	//  ``(null)``
	print ("%s\n", array.index (0));
	print ("%s\n", array.index (1));
	print ("%s\n", array.index (2));
	print ("%s\n", array.index (3));

	return 0;
}
