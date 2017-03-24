public static int main (string[] args) {
	Variant var1 = new Variant.boolean (true);
	// Output: ``true``
	print ("%s\n", var1.get_boolean ().to_string ());
	// Output: ``true``
	print ("%s\n", ((bool) var1).to_string ());
	return 0;
}
