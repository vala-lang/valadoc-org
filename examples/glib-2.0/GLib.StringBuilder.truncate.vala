public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("hello, world!\n I love you!");
	builder.truncate (14);
	stdout.puts (builder.str);
	return 0;
}
