public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Output: ``List.nth (0) = "1. entry"``
	unowned List<string> element = list.nth (0);
	print ("list.nth (0) = \"%s\"\n", element.data);

	// Output: ``List.nth (1) = "2. entry"``
	element = list.nth (1);
	print ("list.nth (1) = \"%s\"\n", element.data);

	// Output: ``List.nth (2) = "3. entry"``
	element = list.nth (2);
	print ("list.nth (2) = \"%s\"\n", element.data);

	// Output: ``List.nth (3) = "3. entry"``
	element = list.nth (3);
	print ("list.nth (3) = \"%p\"\n", element);

	return 0;
}
