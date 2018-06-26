public static int main (string[] args) {
	string str1 = "\xE2\x84\xAB";
	string str2 = "\x41\xCC\x8A";

	// Output: ``"Å", "Å"``
	print ("\"%s\", \"%s\"\n", str1, str2);

	// Output: ``false``
	bool res = (str1 == str2);
	print ("%s\n", res.to_string ());

	// Output: ``true``
	str1 = str1.normalize ();
	str2 = str2.normalize ();
	res = (str1 == str2);
	print ("%s\n", res.to_string ());

	return 0;
}
