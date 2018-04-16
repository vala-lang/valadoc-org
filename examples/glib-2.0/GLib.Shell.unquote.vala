public static int main (string[] args) {
	// Output: ``my str``
	try {
		string str = Shell.unquote ("my str");
		print ("%s\n", str);
	} catch (ShellError e) {
		print ("Error: %s\n", e.message);
	}

	// Output: ``my str``
	try {
		string str = Shell.unquote ("'my str'");
		print ("%s\n", str);
	} catch (ShellError e) {
		print ("Error: %s\n", e.message);
	}

	// Output: ``Error: Unmatched quotation mark in command line or other shell-quoted text``
	try {
		string str = Shell.unquote ("'my str");
		print ("%s\n", str);
	} catch (ShellError e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
