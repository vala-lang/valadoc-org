public static int main (string[] args) {
	HashTable<int, string> table = new HashTable<int, string> (direct_hash, direct_equal);
	table.insert (1, "first string");
	table.insert (2, "second string");
	table.insert (3, "third string");

	// Output: ``"third string" "second string" "first string"``
	foreach (string val in table.get_values ()) {
		print ("\"%s\" ", val);
	}
	print ("\n");

	return 0;
}
