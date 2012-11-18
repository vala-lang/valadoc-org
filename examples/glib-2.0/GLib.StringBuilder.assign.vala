public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("hello, world!\n");
	stdout.puts (builder.str);

	// Output: ``hello, olymp!``
	builder.assign ("hello, olymp!\n");
	stdout.puts (builder.str);
	return 0;
}
