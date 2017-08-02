public static int main () {
	Variant var1 = new Variant.strv ({"a", "b", "c"});
	// Output: ``a,b,c``
	print ("%s\n", string.joinv (",", var1.dup_strv ()));
	// Output: ``a,b,c``
	print ("%s\n", string.joinv (",", var1.get_strv ()));
	// Output: ``a,b,c``
	print ("%s\n", string.joinv (",", (string[]) var1));
	return 0;
}
