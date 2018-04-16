public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("3. entry");
	list.append ("1. entry");
	list.append ("2. entry");

	list.sort (strcmp);

	// Output:
	//  ``1. entry``
	//  ``2. entry``
	//  ``3. entry``
	foreach (string str in list) {
		print ("%s\n", str);
	}

	return 0;
}
