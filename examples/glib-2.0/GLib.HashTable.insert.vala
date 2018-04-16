public static int main (string[] args) {
	HashTable<string, string> table = new HashTable<string, string> (str_hash, str_equal);
	string key1 = "1";	string val1 = "first string";
	string key2 = "2";	string val2 = "second string";
	string key3 = "3";	string val3 = "3. value";

	// Use (owned) to avoid unnecessary copies:
	table.insert ((owned) key1, (owned) val1);
	table.insert ((owned) key2, (owned) val2);
	table.insert ((owned) key3, (owned) val3);

	// Fields are owned by the table:
	assert (key1 == null && key2 == null && key3 == null);
	assert (val1 == null && val2 == null && val3 == null);

	// Overwrite existing entry:
	table.insert ("3", "third string");


	// Output:
	//  ``1 => first string``
	//  ``2 => second string``
	//  ``3 => third string``
	table.foreach ((key, val) => {
		print ("%s => %s\n", key, val);
	});

	return 0;
}
