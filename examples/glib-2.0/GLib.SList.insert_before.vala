public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.append ("1. entry");
	list.append ("3. entry");

	unowned SList<string> list3 = list.nth (1);
	list.insert_before (list3, "2. entry");

	// Out:
	//  ´´1. entry´´
	//  ´´2. entry´´
	//  ´´3. entry´´
	foreach (string str in list) {
		print ("%s\n", str);
	}

	return 0;
}
