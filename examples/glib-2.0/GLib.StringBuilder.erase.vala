public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("hello, economy around the world!\n");
	// "hello, economy around the world!\n"
	//         ^----------------->
	//         7        19
	builder.erase (7, 19);
	print (builder.str);
	return 0;
}
