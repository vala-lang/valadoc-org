public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("helloworld");
	builder.insert (5, ", ");
	builder.insert (12, "!\n");
	print (builder.str);
	return 0;
}
