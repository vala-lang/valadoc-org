public static int main (string[] args) {
	PatternSpec spec = new PatternSpec ("dilbert-????/??/??.*");

	// Output: ``true``
	bool res = spec.match_string ("dilbert-1999/39/01.png");
	print ("%s\n", res.to_string ());

	// Output: ``true``
	res = spec.match_string ("dilbert-1999/39/01.jpg");
	print ("%s\n", res.to_string ());

	// Output: ``false``
	res = spec.match_string ("dilbert-1999X/39/01.jpg");
	print ("%s\n", res.to_string ());

	return 0;
}
