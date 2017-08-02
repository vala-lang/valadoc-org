public static int main (string[] args) {
	// PtrArray array = new PtrArray.with_free_func (GLib.free);
	PtrArray array = new PtrArray ();
	array.set_free_func (GLib.free);

	array.add ("first entry".dup ());
	array.add ("second entry".dup ());
	array.add ("third entry".dup ());

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((ptr) => {
		print ("%s\n", (string) ptr);
	});

	return 0;
}
