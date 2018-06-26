public static int main (string[] args) {
	bool asc = true;

	CompareDataFunc<string> cmpfunc = (a, b) => {
		return (asc)? strcmp (a, b) : strcmp (b, a);
	};

	SList<string> list = new SList<string> ();
	list.insert_sorted_with_data ("2. entry", cmpfunc);
	list.insert_sorted_with_data ("3. entry", cmpfunc);
	list.insert_sorted_with_data ("1. entry", cmpfunc);

	// Out:
	//  ´´1. entry´´
	//  ´´2. entry´´
	//  ´´3. entry´´
	foreach (string str in list) {
		print ("%s\n", str);
	}

	return 0;
}
