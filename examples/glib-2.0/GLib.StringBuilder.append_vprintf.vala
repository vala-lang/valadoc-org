[PrintfFormat]
public static string mysprintf (string str, ...) {
	va_list va_list = va_list ();
	StringBuilder builder = new StringBuilder ();
	builder.append_vprintf (str, va_list);
	return (owned) builder.str;
}

public static int main (string[] args) {
	// Output: ``hello, world!``
	string str = mysprintf ("%s%s%s%s\n", "hello", ", ", "world", "!");
	print (str);
	return 0;
}
