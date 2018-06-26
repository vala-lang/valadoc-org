public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("hello, ");
	builder.append_c ('w').append_c ('o').append_c ('r').append_c ('l').append_c ('d').append_c ('!');
	builder.append_c ('\n');
	print (builder.str);
	return 0;
}
