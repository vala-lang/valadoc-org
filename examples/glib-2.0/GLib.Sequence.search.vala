public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	// sorted data:
	seq.append ("1. Lorem");
	seq.append ("2. ipsum");
	seq.append ("4. sit");
	seq.append ("5. amet");

	SequenceIter<string> iter = seq.search ("3. dolor", (a, b) => {
		return strcmp (a, b);
	});

	// Output: ``4. sit``
	stdout.printf ("%s\n", iter.get ());

	Sequence<string>.insert_before (iter, "3. dolor");

	// Output:
	//  ``1. Lorem``
	//  ``2. ipsum``
	//  ``3. dolor``
	//  ``4. sit``
	//  ``5. amet``
	seq.foreach ((item) => {
		stdout.printf ("%s\n", item);
	});

	return 0;
}
