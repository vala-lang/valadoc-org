public static int main (string[] args) {
	PtrArray array = new PtrArray ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("third entry");

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((ptr) => {
		print ("%s\n", (string) ptr);
	});

	return 0;
}
