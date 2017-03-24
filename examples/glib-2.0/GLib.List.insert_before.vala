public static int main (string[] args) {
	List<int> list = new List<int> ();	
	list.append (1);
	list.append (3);

	// [1, 2] -> [1, 2, 3]
	list.insert_before (list.last (), 2);

	// Output:
	//  ``1``
	//  ``2``
	//  ``3``
	foreach (int i in list) {
		print ("%d\n", i);
	}

	return 0;
}
