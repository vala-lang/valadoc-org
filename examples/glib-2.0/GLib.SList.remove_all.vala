public static int main (string[] args) {
	SList<int> list = new SList<int> ();
	list.append (1);
	list.append (2);
	list.append (3);
	list.append (4);
	list.append (4);

	list.remove_all (4);

	// Out:
	//  ´´1´
	//  ´´2´´
	//  ´´3´´
	foreach (int i in list) {
		print ("%d\n", i);
	}

	return 0;
}
