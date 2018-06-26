public static int main (string[] args) {
	Variant var1 = new Variant.byte ('c');
	// Output: ``c``
	print ("%c\n", var1.get_byte ());
	// Output: ``c``
	print ("%c\n", (uchar) var1);
	return 0;
}
