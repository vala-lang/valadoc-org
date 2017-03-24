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
	print ("%s\n", iter.get ());
	return 0;
}
