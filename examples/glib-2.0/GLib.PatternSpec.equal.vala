public static int main (string[] args) {
	PatternSpec spec = new PatternSpec ("dilbert-????/??/??.*");

	// Output: ``true``
	PatternSpec spec2 = new PatternSpec ("dilbert-????/??/??.****");
	bool res = spec.equal (spec2);
	print ("%s\n", res.to_string ());

	// Output: ``false``
	spec2 = new PatternSpec ("*dilbert-????/??/??.****");
	res = spec.equal (spec2);
	print ("%s\n", res.to_string ());

	return 0;
}
