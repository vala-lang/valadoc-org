public static int main (string[] args) {
	// Output:
	//  ``-2147483648``
	//  ``2147483647``
	//  ``0``

	stdout.printf ("%s\n", int.MIN.to_string ());
	stdout.printf ("%s\n", int.MAX.to_string ());
	stdout.printf ("%s\n", 0.to_string ());
	return 0;
}
