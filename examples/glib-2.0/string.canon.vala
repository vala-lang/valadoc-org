public static int main (string[] args) {
	string str = "glib-2.0";
	// Output: ``?????2.0``
	str.canon ("0123456789.", '?');
	print ("%s\n", str);
	return 0;
}
