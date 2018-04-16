public static int main (string[] args) {
	// Output: ``true``
	bool res = "Would You Like a Jelly Baby".has_prefix ("Would");
	print ("%s\n", res.to_string ());

	// Output: ``false``
	res = "Would You Like a Jelly Baby".has_prefix ("Dalek");
	print ("%s\n", res.to_string ());

	return 0;
}
