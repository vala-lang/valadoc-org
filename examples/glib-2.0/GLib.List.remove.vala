public static int main (string[] args) {
	List<int> list = new List<int> ();	
	list.append (1);
	list.append (2);
	list.append (3);
	list.append (3);

	// remove is ptr based! See remove_link for strings, etc
	// we only remove the first appearance, see remove_all
	list.remove (3);

	// Output:
	//  ``1``
	//  ``2``
	//  ``3``
	foreach (int i in list) {
		print ("%d\n", i);
	}

	return 0;
}
