public static int main (string[] args) {
	PtrArray array = new PtrArray.with_free_func (GLib.free);
	array.add ("first entry".dup ());
	array.add ("second entry".dup ());
	array.add ("third entry".dup ());
	array.add ("fourth entry".dup ());

	array.remove_range (1, 2);

	// Output:
	//  ``first entry``
	//  ``fourth entry``
	array.foreach ((ptr) => {
		print ("%s\n", (string) ptr);
	});

	return 0;
}
