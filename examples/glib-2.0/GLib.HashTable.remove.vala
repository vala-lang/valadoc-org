public static int main (string[] args) {
	HashTable<int, string> table = new HashTable<int, string> (direct_hash, direct_equal);
	table.insert (1, "first string");
	table.insert (2, "second string");
	table.insert (3, "third string");

	// Output: ``first string``
	print ("%s\n", table.lookup (1));

	// Output: ``null``
	table.remove (1);
	print ("%s\n", table.lookup (1));

	return 0;
}
