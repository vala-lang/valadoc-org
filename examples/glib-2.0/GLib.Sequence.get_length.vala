public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.prepend ("amet");
	seq.prepend ("sit");
	seq.prepend ("dolor");
	seq.prepend ("ipsum");
	seq.prepend ("Lorem");

	// Output: ``5``
	print ("%d\n", seq.get_length ());

	return 0;
}
