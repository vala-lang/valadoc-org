public static int main (string[] args) {
	HashTable<int, string> table = new HashTable<int, string> (direct_hash, direct_equal);
	table.insert (1, "first string");
	table.insert (2, "second string");
	table.insert (3, "third string");

	// Output: ``3 2 1``
	foreach (int key in table.get_keys ()) {
		stdout.printf ("%d ", key);
	}
	stdout.putc ('\n');

	return 0;
}
