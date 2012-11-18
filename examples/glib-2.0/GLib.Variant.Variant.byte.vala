public static int main (string[] args) {
	Variant var1 = new Variant.byte ('c');
	// Output: ``c``
	stdout.printf ("%c\n", var1.get_byte ());
	// Output: ``c``
	stdout.printf ("%c\n", (uchar) var1);
	return 0;
}
