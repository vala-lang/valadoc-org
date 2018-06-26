public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("second entry");
	array.add ("third entry");
	array.add ("first entry");

	array.sort (strcmp);

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((str) => {
		print ("%s\n", str);
	});

	return 0;
}
