public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	seq.prepend ("amet");
	seq.prepend ("sit");
	seq.prepend ("dolor");
	seq.prepend ("ipsum");
	seq.prepend ("Lorem");

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
