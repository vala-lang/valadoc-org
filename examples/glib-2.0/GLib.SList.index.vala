public static int main (string[] args) {
	SList<int> list = new SList<int> ();
	list.append (1);
	list.append (2);
	list.append (3);

	// Output: ``valid index: 2``
	int i = list.index (3);
	print ("valid index: %d\n", i);

	// Output: ``valid index: -1``
	i = list.index (4);
	print ("valid index: %d\n", i);

	return 0;
}
