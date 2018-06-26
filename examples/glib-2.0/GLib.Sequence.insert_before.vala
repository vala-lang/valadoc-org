public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("sit");
	seq.append ("amet");

	SequenceIter<string> iter = seq.get_iter_at_pos (2);
	Sequence<string>.insert_before (iter, "dolor");

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
