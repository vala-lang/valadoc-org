public int main (string[] args) {
	//
	// Valid strings:
	//

	// Output: ``true``
	string str = "true";
	bool val = bool.parse (str);
	print ("%s\n", val.to_string ());

	// Output: ``false``
	str = "false";
	val = bool.parse (str);
	print ("%s\n", val.to_string ());


	//
	// Invalid strings:
	//

	// Output: ``false``
	str = "TRUE";
	val = bool.parse (str);
	print ("%s\n", val.to_string ());

	// Output: ``false``
	str = "a string";
	val = bool.parse (str);
	print ("%s\n", val.to_string ());

	// numeric constants are not interpreted as bool!
	// Output: ``false``
	str = "1";
	val = bool.parse (str);
	print ("%s\n", val.to_string ());

	return 0;
}
