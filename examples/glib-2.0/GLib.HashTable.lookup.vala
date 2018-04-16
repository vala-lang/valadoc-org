public static int main (string[] args) {
	HashTable<string, string> table = new HashTable<string, string> (str_hash, str_equal);
	table.insert ("1", "first string");
	table.insert ("2", "second string");
	table.insert ("3", "third string");

	// Output: ``first string``
	unowned string val = table.lookup ("1");
	print ("%s\n", val);

	// Output: ``second string``
	val = table.lookup ("2");
	print ("%s\n", val);

	// Output: ``third string``
	val = table.lookup ("3");
	print ("%s\n", val);

	// Output: ``(null)``
	val = table.lookup ("4");
	print ("%s\n", val);



	HashTable<string, int> table2 = new HashTable<string, int> (str_hash, str_equal);
	table2.insert ("1", 1);

	// Output: ``1``
	int val2 = table2.lookup ("1");
	print ("%d\n", val2);

	// Output: ``0``
	val2 = table2.lookup ("2");
	print ("%d\n", val2);


	HashTable<string, int?> table3 = new HashTable<string, int?> (str_hash, str_equal);
	table3.insert ("1", 1);

	// Output: ``1``
	int? val3 = table3.lookup ("1");
	print ("%d\n", val3);

	// Output: ``(null)``
	val3 = table3.lookup ("2");
	if (val3 == null) {
		print ("(null)\n");
	} else {
		print ("%d\n", val3);
	}

	return 0;
}
