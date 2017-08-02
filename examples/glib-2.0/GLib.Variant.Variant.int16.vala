public static int main () {
	Variant var1 = new Variant.int16 (10);
	// Output: ``10``
	print ("%d\n", var1.get_int16 ());
	// Output: ``10``
	print ("%d\n", (int16) var1);
	return 0;
}
