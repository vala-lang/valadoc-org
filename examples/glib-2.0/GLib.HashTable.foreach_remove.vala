public static int main (string[] args) {
	HashTable<int, string> table = new HashTable<int, string> (direct_hash, direct_equal);
	table.insert (1, "first string");
	table.insert (2, "second string");
	table.insert (3, "third string");

	// Output:
	//  ``1 => first string``
	//  ``2 => second string``
	//  ``3 => third string``
	table.foreach_remove ((key, val) => {
		print ("%d => %s\n", key, val);
		return true; // remove current item!
	});

	// Output: ``Size: 0``
	print ("Size: %u\n", table.size ());

	return 0;
}
