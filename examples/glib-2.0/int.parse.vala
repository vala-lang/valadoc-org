public static int main (string[] args) {
	// Output: ``10``
	print ("%d\n", int.parse ("10"));

	// Output: ``10``
	print ("%d\n", int.parse ("10"));

	// Output: ``10``
	print ("%d\n", int.parse ("10xx"));

	// Output: ``0``
	print ("%d\n", int.parse ("A"));

	// Output: ``0``
	print ("%d\n", int.parse ("a"));

	// Output: ``0``
	print ("%d\n", int.parse ("x11"));

	// Output: ``2147483647``
	print ("%d\n", int.parse ("999999999999999999999999999999999"));

	return 0;
}
