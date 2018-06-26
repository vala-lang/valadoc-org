public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("first entry".dup ());
	array.add ("second entry".dup ());
	array.add ("third entry".dup ());
	array.add ("fourth entry".dup ());

	array.remove_range (1, 2);

	// Output:
	//  ``first entry``
	//  ``fourth entry``
	array.foreach ((str) => {
		print ("%s\n", str);
	});

	return 0;
}
