public static int main (string[] args) {
	SList<string> list1 = new SList<string> ();
	list1.append ("1. entry");
	list1.append ("2. entry");

	SList<string> list2 = new SList<string> ();
	list2.append ("3. entry");

	list1.concat ((owned) list2);
	assert (list2 == null);

	// Out:
	//  ´´1. entry´´
	//  ´´2. entry´´
	//  ´´3. entry´´
	foreach (string str in list1) {
		print ("%s\n", str);
	}

	return 0;
}
