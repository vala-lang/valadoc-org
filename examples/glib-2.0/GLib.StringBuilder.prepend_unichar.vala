public static int main (string[] args) {
	// Output: ``喂, world!``
	StringBuilder builder = new StringBuilder (", world!\n");
	builder.prepend_unichar ('喂');
	print (builder.str);
	return 0;
}
