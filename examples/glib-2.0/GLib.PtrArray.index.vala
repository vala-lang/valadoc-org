public static int main (string[] args) {
	PtrArray array = new PtrArray ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("third entry");

	// Output: ``first entry``
	print ("%s\n", (string) array.index (0));

	// Output: ``second entry``
	print ("%s\n", (string) array.index (1));

	// Output: ``third entry``
	print ("%s\n", (string) array.index (2));

	// Output: ``null``
	print ("%s\n", (string) array.index (3));

	return 0;
}
