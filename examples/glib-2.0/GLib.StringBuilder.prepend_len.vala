public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder (", world!\n");
	builder.prepend_len ("hello, world!", 5);
	print (builder.str);
	return 0;
}
