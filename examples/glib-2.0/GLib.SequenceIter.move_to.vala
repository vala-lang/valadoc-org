public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("dolor");
	seq.append ("ipsum");
	seq.append ("sit");
	seq.append ("amet");

	SequenceIter<string> iter1 = seq.get_iter_at_pos (1);
	SequenceIter<string> iter2 = seq.get_iter_at_pos (3);
	iter1.move_to (iter2);

	// Output:
	//  ``Lorem``
	//  ``ipsum``
	//  ``dolor``
	//  ``sit``
	//  ``amet``
	seq.foreach ((item) => {
		print ("%s\n", item);
	});

	return 0;
}
