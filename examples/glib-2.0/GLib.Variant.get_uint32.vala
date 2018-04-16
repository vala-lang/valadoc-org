public static int main () {
	Variant var1 = new Variant.uint32 (10);
	// Output: ``10``
	print ("%u\n", var1.get_uint32 ());
	// Output: ``10``
	print ("%u\n", (uint32) var1);
	return 0;
}
