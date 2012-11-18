public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("helloworld");
	builder.insert (5, ", ");
	builder.insert (12, "!\n");
	stdout.puts (builder.str);
	return 0;
}
