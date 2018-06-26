public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("1. Lorem");
	seq.append ("2. ipsum");
	seq.append ("4. sit");
	seq.append ("5. amet");

	seq.insert_sorted_iter ("3. dolor", (a, b) => {
		return strcmp (a.get (), b.get ());
	});

	// Output:
	//  ``1. Lorem``
	//  ``2. ipsum``
	//  ``3. dolor``
	//  ``4. sit``
	//  ``5. amet``
	seq.foreach ((item) => {
		print ("%s\n", item);
	});

	return 0;
}
