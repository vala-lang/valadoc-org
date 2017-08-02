public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	// Sorted data:
	seq.append ("1. Lorem");
	seq.append ("3. dolor");
	seq.append ("4. sit");
	seq.append ("2. ipsum");
	seq.append ("5. amet");


	SequenceIter<string> begin = seq.get_iter_at_pos (1);
	SequenceIter<string> end = seq.get_iter_at_pos (3);
	SequenceIter<string> dest = seq.get_iter_at_pos (4);
	Sequence<string>.move_range (dest, begin, end);

	// Output:
	//  ``1. Lorem``
	//  ``2. ipsum``
	//  ``3. dolor``
	//  ``4. sit``
	//  ``5. amet``
	seq.foreach ((item) => {
		print ("%s\n", item);
	});

	return 0;
}
