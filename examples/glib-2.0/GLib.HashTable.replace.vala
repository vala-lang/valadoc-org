public static int main (string[] args) {
	HashTable<string, string> table = new HashTable<string, string> (str_hash, str_equal);
	table.insert ("1", "first string");
	table.insert ("2", "second string");
	table.insert ("3", "3. string");

	// The old key gets replaced by the new key:
	table.replace ("3", "third string");

	// Output:
	//  ``1 => first string``
	//  ``2 => second string``
	//  ``3 => third string``
	table.foreach ((key, val) => {
		print ("%s => %s\n", key, val);
	});

	return 0;
}
