public static int main (string[] args) {
	SList<int> list = new SList<int> ();
	list.append (1);
	list.append (2);
	list.append (3);

	// See find_custom for strings, etc
	// Output: ``0x???????: 3``
	unowned SList<int> list3 = list.find (3);
	print ("%p: %d\n", list3, list3.data);

	return 0;
}
