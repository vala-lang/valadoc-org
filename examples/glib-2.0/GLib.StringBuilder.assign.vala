public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("hello, world!\n");
	print (builder.str);

	// Output: ``hello, olymp!``
	builder.assign ("hello, olymp!\n");
    print (builder.str);
	return 0;
}
