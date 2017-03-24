public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.append ("3. entry");
	list.append ("1. entry");
	list.append ("2. entry");

	bool asc = true;
	list.sort_with_data ((a, b) => {
		return (asc)? strcmp (a, b) : strcmp (b, a);
	});

	// Out:
	//  ´´1. entry´
	//  ´´2. entry´´
	//  ´´3. entry´´
	foreach (string str in list) {
		print ("%s\n", str);
	}

	return 0;
}
