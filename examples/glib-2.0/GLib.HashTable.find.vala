public static int main (string[] args) {
	HashTable<int, string> table = new HashTable<int, string> (direct_hash, direct_equal);
	table.insert (1, "first string");
	table.insert (2, "second string");
	table.insert (3, "third string");

	// Output: ``second string``
	unowned string? str = table.find ((k, v) => {
		return v.has_prefix ("second");
	});
	print ("%s\n", str);

	return 0;
}
