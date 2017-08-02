public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	// sorted data:
	seq.append ("1. Lorem");
	seq.append ("2. ipsum");
	seq.append ("3. dolor");
	seq.append ("4. sit");
	seq.append ("5. amet");

	SequenceIter<string> iter = seq.lookup ("3. dolor", (a, b) => {
		return strcmp (a, b);
	});

	assert (iter != null);

	// Output: ``3. dolor``
	print ("%s\n", iter.get ());
	return 0;
}
