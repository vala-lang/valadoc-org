public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.prepend ("3. entry");
	list.prepend ("2. entry");
	list.prepend ("1. entry");

	// Output:
	//  ``1. entry``
	//  ``2. entry``
	//  ``3. entry``
	foreach (string i in list) {
		print ("%s\n", i);
	}

	return 0;
}
