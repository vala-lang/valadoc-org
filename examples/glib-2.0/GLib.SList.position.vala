public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	unowned SList<string> el3 = list.nth (2);

	// Out: ´´pos: 2´
	int pos = list.position (el3);
	print ("pos: %d\n", pos);

	return 0;
}
