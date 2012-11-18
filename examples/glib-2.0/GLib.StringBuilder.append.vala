public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ();
	builder.append ("hello").append (", world!\n");
	stdout.puts (builder.str);
	return 0;
}
