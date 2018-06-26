public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("third entry");

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	string[] data = array.data;
	foreach (unowned string str in data) {
		print ("%s\n", str);
	}

	return 0;
}
