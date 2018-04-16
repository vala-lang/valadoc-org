public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Output: ``List.nth_data (0) = "1. entry"``
	unowned string? data = list.nth_data (0);
	print ("list.nth_data (0) = \"%s\"\n", data);

	// Output: ``List.nth_data (1) = "2. entry"``
	data = list.nth_data (1);
	print ("list.nth_data (1) = \"%s\"\n", data);

	// Output: ``List.nth_data (2) = "3. entry"``
	data = list.nth_data (2);
	print ("list.nth_data (2) = \"%s\"\n", data);

	// Output: ``List.nth_data (3) = "3. entry"``
	// Don't do that for value types. (e.g. int, uint, ...)
	data = list.nth_data (3);
	print ("list.nth_data (3) = \"%p\"\n", data);

	return 0;
}
