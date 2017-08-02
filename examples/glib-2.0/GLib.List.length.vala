public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Output:
	//  ``List length: 3``
	uint len = list.length ();
	print ("List length: %u\n", len);
	return 0;
}
