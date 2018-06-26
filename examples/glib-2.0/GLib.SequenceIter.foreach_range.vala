public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("dolor");
	seq.append ("sit");
	seq.append ("amet");

	SequenceIter<string> start = seq.get_iter_at_pos (2);
	SequenceIter<string> end = seq.get_end_iter ();

	// Output:
	//  ``dolor``
	//  ``sit``
	//  ``amet``
	start.foreach_range (end, (item) => {
		print ("%s\n", item);
	});

	return 0;
}
