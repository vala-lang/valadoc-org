public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("second entry");
	array.add ("third entry");
	array.add ("first entry");

	bool asc = true;
	array.sort_with_data ((a, b) => {
		return (asc)? strcmp (a, b) : strcmp (b, a);
	});

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((str) => {
		print ("%s\n", str);
	});

	return 0;
}
