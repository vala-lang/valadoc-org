public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("XXX");
	array.add ("third entry");

	array.remove_index (2);

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((str) => {
		print ("%s\n", str);
	});

	return 0;
}
