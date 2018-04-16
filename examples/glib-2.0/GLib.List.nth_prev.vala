public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Output:
	//  ``Data: list.nth(2): 3. entry, list[2-2] = 1. entry``

	// [1, 2, 3]
	//  ^<----^
	unowned List<string> list3 = list.nth (2);
	unowned List<string> list1 = list3.nth_prev (2);
	print ("Data: list.nth(2): %s, list[2-2] = %s\n", list3.data, list1.data);
	return 0;
}
