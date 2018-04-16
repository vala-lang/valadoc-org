public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("first entry");
	array.add ("2. entry");
	array.add ("third entry");

	array.set (1, "second entry");

	// Output:
	//  ``first entry``
	//  ``second entry``
	//  ``third entry``
	array.foreach ((str) => {
		print ("%s\n", str);
	});

	return 0;
}
