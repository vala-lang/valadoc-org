public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("XXXXX");
	seq.append ("XXXXX");
	seq.append ("dolor");
	seq.append ("sit");
	seq.append ("amet");

	SequenceIter<string> iter_start = seq.get_iter_at_pos (2);
	SequenceIter<string> iter_end = seq.get_iter_at_pos (4);
	iter_start.remove_range (iter_end);

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
