public static int main (string[] args) {
	HashTable<string, unowned string> table = new HashTable<string, unowned string> (str_hash, str_equal);

	// HashTable is used as set:
	string keyval1 = "first string";
	string keyval2 = "second string";
	string keyval3 = "third string";
	string keyval4 = "third string";

	// Use (owned) to avoid unnecessary copies:
	table.add ((owned) keyval1);
	table.add ((owned) keyval2);
	table.add ((owned) keyval3);
	table.add ((owned) keyval4);

	// Fields are owned by the table:
	assert (keyval1 == null && keyval2 == null && keyval3 == null);

	// Output:
	//  ``second string: 0x809d5d0 => 0x809d5d0``
	//  ``third string: 0x809d600 => 0x809d600``
	//  ``first string: 0x809d5b8 => 0x809d5b8``
	table.foreach ((key, val) => {
		print ("%s: %p => %p\n", key, key, val);
	});

	return 0;
}
