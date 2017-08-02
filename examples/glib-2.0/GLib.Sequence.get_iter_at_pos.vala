public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("dolor");
	seq.append ("sit");
	seq.append ("amet");

	// Output: ``ipsum``
	SequenceIter<string> iter = seq.get_iter_at_pos (1);
	print ("%s\n", iter.get ());

	return 0;
}
