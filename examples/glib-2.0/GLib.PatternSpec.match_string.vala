public static int main (string[] args) {
	PatternSpec spec = new PatternSpec ("dilbert-????/??/??.*");

	// Output: ``true``
	bool res = spec.match_string ("dilbert-1999/39/01.png");
	stdout.printf ("%s\n", res.to_string ());

	// Output: ``true``
	res = spec.match_string ("dilbert-1999/39/01.jpg");
	stdout.printf ("%s\n", res.to_string ());

	// Output: ``false``
	res = spec.match_string ("dilbert-1999X/39/01.jpg");
	stdout.printf ("%s\n", res.to_string ());

	return 0;
}
