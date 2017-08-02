public static int main (string[] args) {
	// Output: ``hello, 世界!``
	StringBuilder builder = new StringBuilder ("hello, ");
	builder.append_unichar ('世');
	builder.append_unichar ('界');
	builder.append ("!\n");
	print (builder.str);
	return 0;
}
