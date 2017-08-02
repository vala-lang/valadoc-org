public static int main () {
	Variant var1 = new Variant.uint64 (10);
	// Output: ``10``
	print ("%"+uint64.FORMAT+"\n", var1.get_uint64 ());
	// Output: ``10``
	print ("%"+uint64.FORMAT+"\n", (uint64) var1);
	return 0;
}
