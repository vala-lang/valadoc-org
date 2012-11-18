public static int main (string[] args) {
	List<string> list1 = new List<string> ();	
	list1.append ("1. entry");
	list1.append ("2. entry");
	list1.append ("3. entry");

	List<string> list2 = new List<string> ();	
	list2.append ("4. entry");
	list2.append ("5. entry");
	list2.append ("6. entry");

	list1.concat ((owned) list2);
	// list2 is null now!


	// Output:
	//  ``list 1:``
	//  `` 1. entry``
	//  `` 2. entry``
	//  `` 3. entry``
	//  `` 4. entry``
	//  `` 5. entry``
	//  `` 6. entry``
	stdout.puts ("list 1:\n");
	foreach (unowned string e in list1) {
		stdout.printf (" %s\n", e);
	}

	// Output:
	//  ``list 2:``
	//  `` (null)``
	stdout.puts ("list 2:\n");
	stdout.printf (" %p\n", list2);

	return 0;
}
