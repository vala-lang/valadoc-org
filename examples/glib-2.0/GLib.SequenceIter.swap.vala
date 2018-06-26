public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("dolor");
	seq.append ("amet");
	seq.append ("sit");

	SequenceIter<string> iter1 = seq.get_iter_at_pos (3);
	SequenceIter<string> iter2 = seq.get_iter_at_pos (4);
	iter1.swap (iter2);

	// Output:
	//  ``Lorem``	(Lorem)
	//  ``ipsum``	(ipsum)
	//  ``dolor``	(dolor)
	//  ``sit``		(amet)
	//  ``amet``	(sit)
	seq.foreach ((item) => {
		print ("%s\n", item);
	});

	return 0;
}
