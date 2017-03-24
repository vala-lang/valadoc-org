public static int main (string[] args) {
	bool desc = true;

	CompareDataFunc<string> mystrcmp = (a, b) => {
		return (desc)? strcmp (a, b) : -1*strcmp (a, b);
	};

	List<string> list = new List<string> ();	
	list.insert_sorted_with_data ("2. entry", mystrcmp); // [2]
	list.insert_sorted_with_data ("3. entry", mystrcmp); // [2, 3]

	desc = false;
	list.insert_sorted_with_data ("1. entry", mystrcmp); // [2, 3, 1]

	// Output:
	//  ``2. entry``
	//  ``3. entry``
	//  ``1. entry``
	foreach (string str in list) {
		print ("%s\n", str);
	}


	return 0;
}
