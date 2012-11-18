public static int main (string[] args) {
	// Output: ``true``
	bool res = PatternSpec.match_simple ("dilbert-????/??/??.*", "dilbert-1999/39/01.png");
	stdout.printf ("%s\n", res.to_string ());

	// Output: ``true``
	res = PatternSpec.match_simple ("dilbert-????/??/??.*", "dilbert-1999/39/01.jpg");
	stdout.printf ("%s\n", res.to_string ());

	// Output: ``false``
	res = PatternSpec.match_simple ("dilbert-????/??/??.*", "dilbert-1999X/39/01.jpg");
	stdout.printf ("%s\n", res.to_string ());

	return 0;
}
