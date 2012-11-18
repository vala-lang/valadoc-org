public static int main (string[] args) {
	List<int> list = new List<int> ();	
	list.append (1);
	list.append (2);
	list.append (3);

	// Output:
	//  `` 3 => 3 (found)``
	int index = list.index (3); // available
	stdout.printf (" %d => 3 (found)\n", index);


	// Output:
	//  ``-1 => 4  (not found)``
	index = list.index (4); // not available
	stdout.printf ("%d => 4 (not found)\n", index);

	return 0;
}
