public static int main () {
	Variant var1 = new Variant.bytestring_array ({"a", "b", "c"});

	// Output: ``a, b, c``
	print ("%s\n", string.joinv (",", var1.dup_bytestring_array ()));
	// Output: ``a, b, c``
	print ("%s\n", string.joinv (",", var1.get_bytestring_array ()));

	return 0;
}
