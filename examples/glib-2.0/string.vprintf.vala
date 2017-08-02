public static void my_printf (string format, ...) {
	va_list va_list = va_list ();
	string res = format.vprintf (va_list);
	print (res);
}

public static int main (string[] args) {
	// Output: ``Shut up, K-9!``
	my_printf ("Shut %s, %c-%d!\n", "up", 'K', 9);
	return 0;
}
