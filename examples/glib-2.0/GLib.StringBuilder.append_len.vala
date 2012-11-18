public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder subbuilder = new StringBuilder ("hello");
	StringBuilder builder = new StringBuilder ();
	builder.append_len (subbuilder.str, subbuilder.len);
	builder.append_len (", world!\n", 9);
	stdout.puts (builder.str);
	return 0;
}
