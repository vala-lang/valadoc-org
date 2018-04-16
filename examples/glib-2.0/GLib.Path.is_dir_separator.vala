public static int main (string[] args) {
	// Output: ``false``
	bool res = Path.is_dir_separator ('i');
	print ("%s\n", res.to_string ());

	// Output: ``true``
	res = Path.is_dir_separator ('/') || Path.is_dir_separator ('\\');
	print ("%s\n", res.to_string ());

	return 0;
}
