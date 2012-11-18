public static int main (string[] args) {
	GenericArray<string> array = new GenericArray<string> ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("third entry");

	// Output: ``3``
	stdout.printf ("%u\n", array.length);

	// Output: ``4, [3] = (null)``
	array.length = 4;
	stdout.printf ("%u, [3] = %s\n", array.length, array.get (3));

	// Output: ``2``
	array.length = 2;
	stdout.printf ("%u\n", array.length);


	return 0;
}
