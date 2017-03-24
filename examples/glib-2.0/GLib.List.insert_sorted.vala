public static int main (string[] args) {
	List<string> list = new List<string> ();	
	list.insert_sorted ("CC", strcmp);
	list.insert_sorted ("AA", strcmp);
	list.insert_sorted ("BB", strcmp);

	// Output:
	//  ``AA``
	//  ``BB``
	//  ``CC``
	foreach (string str in list) {
		print ("%s\n", str);
	}

	return 0;
}
