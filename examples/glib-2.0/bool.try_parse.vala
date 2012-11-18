public int main (string[] args) {
	bool result = false;

	// Output: ``true``
	if (bool.try_parse ("true", out result)) {
		stdout.printf ("%s\n", result.to_string ());
	} else {
		stdout.printf ("Error! %s\n", result.to_string ());
	}


	// Output: ``Error! false``
	if (bool.try_parse ("TRUE", out result)) {
		stdout.printf ("%s\n", result.to_string ());
	} else {
		stdout.printf ("Error! %s\n", result.to_string ());
	}


	// Output: ``Error! false``
	if (bool.try_parse ("1", out result)) {
		stdout.printf ("%s\n", result.to_string ());
	} else {
		stdout.printf ("Error! %s\n", result.to_string ());
	}

	return 0;
}
