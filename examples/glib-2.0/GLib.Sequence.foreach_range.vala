public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("dolor");
	seq.append ("sit");
	seq.append ("amet");

	SequenceIter start = seq.get_iter_at_pos (2);
	SequenceIter end = seq.get_end_iter ();

	// Output:
	//  ``dolor``
	//  ``sit``
	//  ``amet``
	Sequence<string>.foreach_range (start, end, (item) => {
		print ("%s\n", item);
	});

	return 0;
}
