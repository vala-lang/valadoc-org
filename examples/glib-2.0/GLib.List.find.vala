public static int main (string[] args) {
	List<string> list1 = new List<string> ();	
	list1.append ("1. entry");
	list1.append ("2. entry");
	list1.append ("3. entry");

	// find is ptr based! See list.find_custom ()
	// Output:
	//  ``Search result: (nil)``
	unowned List<string>? scnd1 = list1.find ("3. entry");
	print ("Search result: %p\n", scnd1);
	assert (scnd1 == null);


	List<int> list2 = new List<int> ();	
	list2.append (1);
	list2.append (2);
	list2.append (3);

	// Output:
	//  ``Search result: 0x???????: 3``
	unowned List<int>? scnd2 = list2.find (3);
	print ("Search result: %p: %d\n", scnd2, scnd2.data);
	assert (scnd2 != null);

	return 0;
}
