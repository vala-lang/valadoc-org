public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.append ("1. entry");
	list.append ("3. entry");

	list.insert ("2. entry", 1);

	// Out:
	//  ´´1. entry´´
	//  ´´2. entry´´
	//  ´´3. entry´´
	foreach (string str in list) {
		print ("%s\n", str);
	}

	return 0;
}
