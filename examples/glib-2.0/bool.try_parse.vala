public int main (string[] args) {
	bool result = false;

	// Output: ``true``
	if (bool.try_parse ("true", out result)) {
		print ("%s\n", result.to_string ());
	} else {
		print ("Error! %s\n", result.to_string ());
	}


	// Output: ``Error! false``
	if (bool.try_parse ("TRUE", out result)) {
		print ("%s\n", result.to_string ());
	} else {
		print ("Error! %s\n", result.to_string ());
	}


	// Output: ``Error! false``
	if (bool.try_parse ("1", out result)) {
		print ("%s\n", result.to_string ());
	} else {
		print ("Error! %s\n", result.to_string ());
	}

	return 0;
}
