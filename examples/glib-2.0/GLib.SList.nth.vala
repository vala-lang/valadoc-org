public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Out: ´´2. element: "2. entry"´´
	unowned SList<string> el = list.nth (1);
	print ("2. element: \"%s\"\n", el.data);

	return 0;
}
