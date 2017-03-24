public static int main () {
	Variant var1 = new Variant.int32 (10);
	// Output: ``10``
	print ("%d\n", var1.get_int32 ());
	// Output: ``10``
	print ("%d\n", (int32) var1);
	return 0;
}
