public static void myprintf (string msg, ...) {
	va_list va_list = va_list ();
	stdout.vprintf ("Error: " + msg + "\n", va_list);
}

public static int main (string[] args) {
	// Output: ``error: 10: My error message``
	myprintf ("%d: My %s message", 10, "error");
	return 0;
}
