public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Output:
	//  ``Search result: 0x??????: '3. entry'``
	unowned List<string>? element = list.find_custom ("3. entry", strcmp);
	assert (element != null);
	print ("Search result: %p: '%s'\n", element, element.data);

	return 0;
}
