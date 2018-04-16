public static int main () {
	Variant var1 = new Variant.int64 (10);
	// Output: ``10``
	print ("%"+int64.FORMAT+"\n", var1.get_int64 ());
	// Output: ``10``
	print ("%"+int64.FORMAT+"\n", (int64) var1);
	return 0;
}
