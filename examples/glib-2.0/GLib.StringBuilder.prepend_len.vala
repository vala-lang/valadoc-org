public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder (", world!\n");
	builder.prepend_len ("hello, world!", 5);
	stdout.puts (builder.str);
	return 0;
}
