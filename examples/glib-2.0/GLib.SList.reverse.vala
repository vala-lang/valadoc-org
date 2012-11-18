public static int main (string[] args) {
	SList<int> list = new SList<int> ();
	list.append (3);
	list.append (2);
	list.append (1);

	list.reverse ();

	// Out:
	//  ´´1´
	//  ´´2´´
	//  ´´3´´
	foreach (int i in list) {
		stdout.printf ("%d\n", i);
	}

	return 0;
}
