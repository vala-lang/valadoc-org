public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Output:
	//  ``Search result: 0x???????.data: '3. entry'``
    //  ``               0x???????.prev: 0x???????:'2. entry'``
    //  ``               0x???????.next: (nil)``
	unowned List<string>? element = list.last ();
	assert (element != null);
	print ("Search result: %p.data: '%s'\n", element, element.data);
	print ("               %p.prev: %p:'%s'\n", element, element.prev, element.prev.data);
	print ("               %p.next: %p\n", element, element.next);

	return 0;
}
