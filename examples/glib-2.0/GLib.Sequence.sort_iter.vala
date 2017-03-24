public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("1. Lorem");
	seq.append ("4. amet");
	seq.append ("2. ipsum");
	seq.append ("3. sit");

	bool asc = true;
	seq.sort_iter ((a, b) => {
		return (asc)? strcmp (a.get (), b.get ()) : strcmp (b.get (), a.get ());
	});

	// Output:
	//  ``1. Lorem``
	//  ``2. ipsum``
	//  ``3. sit``
	//  ``4. amet``
	seq.foreach ((item) => {
		print ("%s\n", item);
	});

	return 0;
}
