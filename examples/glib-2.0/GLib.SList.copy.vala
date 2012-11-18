public static int main (string[] args) {
	SList<string> list1 = new SList<string> ();
	list1.append ("1. entry");
	list1.append ("2. entry");
	list1.append ("3. entry");

	SList<string> list2 = list1.copy ();
	list2.append ("4. entry");

	// Out:
	//  ´´list1: 1. entry´´
	//  ´´list1: 2. entry´´
	//  ´´list1: 3. entry´´
	foreach (string str in list1) {
		stdout.printf ("list1: %s\n", str);
	}

	// Out:
	//  ´´list2: 1. entry´´
	//  ´´list2: 2. entry´´
	//  ´´list2: 3. entry´´
	//  ´´list2: 4. entry´´
	foreach (string str in list2) {
		stdout.printf ("list2: %s\n", str);
	}

	return 0;
}
