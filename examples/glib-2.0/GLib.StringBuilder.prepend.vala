public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ();
	builder.prepend ("world!\n");
	builder.prepend ("hello, ");
	stdout.puts (builder.str);
	return 0;
}
