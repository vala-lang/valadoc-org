public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("third entry");

	// Output: ``first entry``
	print ("%s\n", array.get (0));

	// Output: ``second entry``
	print ("%s\n", array.get (1));

	// Output: ``third entry``
	print ("%s\n", array.get (2));

	// Output: ``null``
	print ("%s\n", array.get (3));

	return 0;
}
