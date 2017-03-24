public static int main (string[] args) {
	GenericSet<string> table = new GenericSet<string> (str_hash, str_equal);

	string keyval1 = "first string";
	string keyval2 = "second string";
	string keyval3 = "third string";
	string keyval4 = "third string";

	// Use (owned) to avoid unnecessary copies:
	table.add ((owned) keyval1);
	table.add ((owned) keyval2);
	table.add ((owned) keyval3);
	table.add ((owned) keyval4);


	// Fields are owned by GenericSet:
	assert (keyval1 == null && keyval2 == null && keyval3 == null);

	// Output:
	//  ``second string => 0x809d5d0``
	//  ``third string => 0x809d600``
	//  ``first string => 0x809d5b8``
	table.foreach ((key) => {
		print ("%s => %p\n", key, key);
	});

	return 0;
}
