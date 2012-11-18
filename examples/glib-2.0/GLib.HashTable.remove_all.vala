public static int main (string[] args) {
	HashTable<int, string> table = new HashTable<int, string> (direct_hash, direct_equal);
	table.insert (1, "first string");
	table.insert (2, "second string");
	table.insert (3, "third string");

	// Output: ``Size: 3``
	stdout.printf ("Size: %u\n", table.size ());

	// Output: ``Size: 0``
	table.remove_all ();
	stdout.printf ("Size: %u\n", table.size ());

	return 0;
}
