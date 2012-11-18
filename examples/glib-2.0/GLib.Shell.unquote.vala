public static int main (string[] args) {
	// Output: ``my str``
	try {
		string str = Shell.unquote ("my str");
		stdout.printf ("%s\n", str);
	} catch (ShellError e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	// Output: ``my str``
	try {
		string str = Shell.unquote ("'my str'");
		stdout.printf ("%s\n", str);
	} catch (ShellError e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	// Output: ``Error: Unmatched quotation mark in command line or other shell-quoted text``
	try {
		string str = Shell.unquote ("'my str");
		stdout.printf ("%s\n", str);
	} catch (ShellError e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
