public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ();
	builder.append_printf ("%s, %s!\n", "hello", "world");
	stdout.puts (builder.str);
	return 0;
}
