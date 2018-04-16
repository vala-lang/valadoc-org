public static int main (string[] args) {
	// Output: ``true``
	bool res = PatternSpec.match_simple ("dilbert-????/??/??.*", "dilbert-1999/39/01.png");
	print ("%s\n", res.to_string ());

	// Output: ``true``
	res = PatternSpec.match_simple ("dilbert-????/??/??.*", "dilbert-1999/39/01.jpg");
	print ("%s\n", res.to_string ());

	// Output: ``false``
	res = PatternSpec.match_simple ("dilbert-????/??/??.*", "dilbert-1999X/39/01.jpg");
	print ("%s\n", res.to_string ());

	return 0;
}
