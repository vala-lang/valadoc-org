public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("sit");
	seq.append ("amet");

	SequenceIter<string> iter1 = seq.get_iter_at_pos (0);
	SequenceIter<string> iter2 = seq.get_iter_at_pos (3);

	// Output: ``1``
	SequenceIter<string> res = Sequence<string>.range_get_midpoint (iter1, iter2);
	print ("%u\n", res.get_position ());

	// Output: ``2``
	iter1 = seq.get_iter_at_pos (1);
	res = Sequence<string>.range_get_midpoint (iter1, iter2);
	print ("%u\n", res.get_position ());

	return 0;
}
