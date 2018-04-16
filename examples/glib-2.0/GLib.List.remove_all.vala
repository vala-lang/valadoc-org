public static int main (string[] args) {
	List<int> list = new List<int> ();	
	list.append (1);
	list.append (2);
	list.append (3);
	list.append (4);
	list.append (4);

	// remove_all is ptr based!
	list.remove_all (4);

	// Output:
	//  ``1``
	//  ``2``
	//  ``3``
	foreach (int i in list) {
		print ("%d\n", i);
	}

	return 0;
}
