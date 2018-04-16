public static int main (string[] args) {
	SList<int> list = new SList<int> ();
	list.append (1);
	list.append (2);
	list.append (3);
	list.append (3);

	// rm the first appearance, see remove_all
	list.remove (3);

	// Out:
	//  ´´1´
	//  ´´2´´
	//  ´´3´´
	foreach (int i in list) {
		print ("%d\n", i);
	}

	return 0;
}
