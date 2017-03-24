public static int main (string[] args) {
	List<int> list = new List<int> ();	
	list.insert (2, 0); // [2]
	list.insert (3, 1); // [2, 3]
	list.insert (1, 0); // [1, 2, 3]

	// Output:
	//  ``1``
	//  ``2``
	//  ``3``
	foreach (int i in list) {
		print ("%d\n", i);
	}

	return 0;
}
