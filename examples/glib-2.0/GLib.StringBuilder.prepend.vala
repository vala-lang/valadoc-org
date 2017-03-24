public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ();
	builder.prepend ("world!\n");
	builder.prepend ("hello, ");
	print (builder.str);
	return 0;
}
