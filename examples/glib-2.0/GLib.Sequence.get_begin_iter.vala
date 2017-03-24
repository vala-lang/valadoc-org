public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.append ("Lorem");
	seq.append ("ipsum");
	seq.append ("dolor");
	seq.append ("sit");
	seq.append ("amet");

	// Output:
	//  ``Lorem``
	//  ``ipsum``
	//  ``dolor``
	//  ``sit``
	//  ``amet``
	for (SequenceIter<string> iter = seq.get_begin_iter (); !iter.is_end (); iter = iter.next ()) {
		print ("%d: %s\n", iter.get_position (), iter.get ());
	}

	return 0;
}
