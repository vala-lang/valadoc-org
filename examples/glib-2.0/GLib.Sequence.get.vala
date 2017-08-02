public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("dolor");
	seq.append ("sit");
	seq.append ("amet");

	// Output: ``Lorem``
	SequenceIter<string> iter = seq.get_begin_iter ();
	print ("%s\n", Sequence<string>.get (iter));

	return 0;
}
