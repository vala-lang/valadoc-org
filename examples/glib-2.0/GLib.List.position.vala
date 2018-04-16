public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Get 3. element:
	// Output: ``list.nth (0) = "3. entry"``
	unowned List<string> element = list.nth (2);
	print ("list.nth (2) = \"%s\"\n", element.data);

	// Calculate the position:
	// Output: ``Position: list.position () = 2``
	int pos = list.position (element);
	print ("Position: list.position () = %d\n", pos);

	return 0;
}
