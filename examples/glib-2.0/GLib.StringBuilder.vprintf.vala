public static string myprintf (string str, ...) {
	va_list va_list = va_list ();
	StringBuilder builder = new StringBuilder ("foo bar foo");
	builder.vprintf (str, va_list);
	return (owned) builder.str;
}

public static int main (string[] args) {
	// Output: ``hello, world!``
	string str = myprintf ("%s, %s!\n", "hello", "world");
	stdout.puts (str);
	return 0;
}
