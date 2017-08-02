public static int main (string[] args) {
	PtrArray array = new PtrArray ();
	string xxx = "XXXX";

	array.add ("first entry");
	array.add ("second entry");
	array.add (xxx);
	array.add ("third entry");

	array.remove (xxx);

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((ptr) => {
		print ("%s\n", (string) ptr);
	});

	return 0;
}
