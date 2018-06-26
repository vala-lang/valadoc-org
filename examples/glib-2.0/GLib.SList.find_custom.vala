public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// See find_custom for strings, etc
	// Output: ``0x???????: "3. entry"``
	unowned SList<string> list3 = list.find_custom ("3. entry", strcmp);
	print ("%p: \"%s\"\n", list3, list3.data);

	return 0;
}
