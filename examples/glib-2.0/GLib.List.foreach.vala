public static int main (string[] args) {
	List<string> list = new List<string> ();
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Output:
	//  ``1. entry``
	//  ``2. entry``
	//  ``3. entry``

	list.foreach ((entry) => {
		print (@"$entry\n");
	});

	return 0;
}
