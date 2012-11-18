public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	unowned List<string> scnd = list.nth (1);
	list.delete_link (scnd);

	// Output:
	//  ``list 1:``
	//  `` 1. entry``
	//  `` 3. entry``
	stdout.puts ("list:\n");
	foreach (unowned string e in list) {
		stdout.printf (" %s\n", e);
	}

	return 0;
}
