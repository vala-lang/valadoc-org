public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("hello, world!\n I love you!");
	builder.truncate (14);
	print (builder.str);
	return 0;
}
