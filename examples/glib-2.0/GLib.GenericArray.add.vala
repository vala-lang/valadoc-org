public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	string val1 = "first entry";
	string val2 = "second entry";
	string val3 = "third entry";

	// Use (owned) to avoid copies:
	array.add ((owned) val1);
	array.add ((owned) val2);
	array.add ((owned) val3);
	assert (val1 == null && val2 == null && val3 == null);


	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((item) => {
		print ("%s\n", item);
	});

	return 0;
}
