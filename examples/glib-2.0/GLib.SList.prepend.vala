public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.prepend ("3. entry");
	list.prepend ("2. entry");
	list.prepend ("1. entry");

	// Out:
	//  ´´1. entry´´
	//  ´´2. entry´´
	//  ´´3. entry´´
	foreach (string str in list) {
		print ("%s\n", str);
	}

	return 0;
}
