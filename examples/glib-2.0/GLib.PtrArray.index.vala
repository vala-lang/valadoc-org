public static int main (string[] args) {
	PtrArray array = new PtrArray ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("third entry");

	// Output: ``first entry``
	stdout.printf ("%s\n", (string) array.index (0));

	// Output: ``second entry``
	stdout.printf ("%s\n", (string) array.index (1));

	// Output: ``third entry``
	stdout.printf ("%s\n", (string) array.index (2));

	// Output: ``null``
	stdout.printf ("%s\n", (string) array.index (3));

	return 0;
}
