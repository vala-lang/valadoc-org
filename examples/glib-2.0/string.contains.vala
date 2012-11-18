public static int main (string[] args) {
	// Output: ``true``
	bool res = "1234567890".contains ("678");
	stdout.printf ("%s\n", res.to_string ());

	// Output: ``false``
	res = "1234567890".contains ("ABC");
	stdout.printf ("%s\n", res.to_string ());

	return 0;
}
