public static int main (string[] args) {
	Variant var1 = new Variant.bytestring ("Hello, world!");

	// Output: ``'Hello, world!'``
	stdout.printf ("'%s'\n", var1.get_bytestring ());

	return 0;
}
