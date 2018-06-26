public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder (", world!\n");
	builder.prepend_c ('o').prepend_c ('l').prepend_c ('l').prepend_c ('e').prepend_c ('h');
	print (builder.str);
	return 0;
}
