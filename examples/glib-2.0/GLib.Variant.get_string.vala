public static int main (string[] args) {
	Variant var1 = new Variant.string ("Hello, world!");
	size_t length = 0;

	// Output: ``'Hello, world!', 13``
	print ("'%s', %"+size_t.FORMAT+"\n", var1.get_string (out length), length);

	return 0;
}
