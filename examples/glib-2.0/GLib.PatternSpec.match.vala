public static int main (string[] args) {
	PatternSpec spec = new PatternSpec ("dilbert-????/??/??.*");

	// Output: ``true``
	string str = "dilbert-1999/39/01.png";
	bool res = spec.match (str.length, str, str.reverse ());
	print ("%s\n", res.to_string ());

	// Output: ``true``
	str = "dilbert-1999/39/01.jpg";
	res = spec.match (str.length, str, null);
	print ("%s\n", res.to_string ());

	// Output: ``false``
	str = "dilbert-1999X/39/01.jpg";
	res = spec.match (str.length, str, null);
	print ("%s\n", res.to_string ());

	return 0;
}
