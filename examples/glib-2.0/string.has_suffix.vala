public static int main (string[] args) {
	// Output: ``true``
	bool res = "Would You Like a Jelly Baby".has_suffix ("Baby");
	stdout.printf ("%s\n", res.to_string ());

	// Output: ``false``
	res = "Would You Like a Jelly Baby".has_suffix ("Would");
	stdout.printf ("%s\n", res.to_string ());

	return 0;
}
