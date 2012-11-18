public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Output:
	//  ``Search result: 0x??????: '1. entry'``
	//  ``               0x??????: (nil)``
	//  ``               0x??????: 0x??????:'2. entry'``
	unowned List<string>? element = list.first ();
	assert (element != null);
	stdout.printf ("Search result: %p.data: '%s'\n", element, element.data);
	stdout.printf ("               %p.prev: %p\n", element, element.prev);
	stdout.printf ("               %p.next: %p:'%s'\n", element, element.next, element.next.data);

	return 0;
}
