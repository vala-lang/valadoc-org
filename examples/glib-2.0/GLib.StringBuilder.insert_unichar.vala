public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("hello world\n");
	builder.insert_unichar (5, ',');
	builder.insert_unichar (12, '!');
	print (builder.str);
	return 0;
}
