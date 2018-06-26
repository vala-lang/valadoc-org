public static int main (string[] args) {
	HashTable<int, string> table = new HashTable<int, string> (direct_hash, direct_equal);
	table.insert (1, "first string");
	table.insert (2, "second string");
	table.insert (3, "third string");

	// Output: ``true``
	print ("%s\n", table.contains (1).to_string ());
	// Output: ``true``
	print ("%s\n", table.contains (2).to_string ());
	// Output: ``true``
	print ("%s\n", table.contains (3).to_string ());
	// Output: ``false``
	print ("%s\n", table.contains (4).to_string ());

	return 0;
}
