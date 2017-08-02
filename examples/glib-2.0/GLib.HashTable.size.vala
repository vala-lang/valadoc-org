public static int main (string[] args) {
	HashTable<int, string> table = new HashTable<int, string> (direct_hash, direct_equal);
	table.insert (0, "first string");
	table.insert (1, "second string");
	table.insert (2, "third string");

	// Output: ``3``
	print ("%u\n", table.size ());

	// Output: ``4``
	table.insert (3, "third string");
	print ("%u\n", table.size ());

	return 0;
}
