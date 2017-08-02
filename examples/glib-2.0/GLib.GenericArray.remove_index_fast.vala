public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("XXXX");
	array.add ("third entry");
	array.add ("fourth entry");

	array.remove_index_fast (2);

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``fourth entry``
	//  ``third entry``
	array.foreach ((str) => {
		print ("%s\n", str);
	});

	return 0;
}
