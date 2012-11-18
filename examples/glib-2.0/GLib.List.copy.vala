public static int main (string[] args) {
	List<string> list1 = new List<string> ();	
	list1.append ("1. entry");
	list1.append ("2. entry");
	list1.append ("3. entry");

	List<string> list2 = list1.copy ();
	list2.append ("4. entry");

	// Output:
	//  ``list 1:``
	//  `` 1. entry``
	//  `` 2. entry``
	//  `` 3. entry``
	stdout.puts ("list 1:\n");
	foreach (unowned string e in list1) {
		stdout.printf (" %s\n", e);
	}

	// Output:
	//  ``list 2:``
	//  `` 1. entry``
	//  `` 2. entry``
	//  `` 3. entry``
	//  `` 4. entry``
	stdout.puts ("list 2:\n");
	foreach (unowned string e in list2) {
		stdout.printf (" %s\n", e);
	}

	return 0;
}
