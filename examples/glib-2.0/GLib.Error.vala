public static void dummy () throws FileError {
	throw new FileError.ACCES ("My error msg");
}

public static int main (string[] args) {
	try {
		dummy ();
	} catch (FileError e) {
		// Output:
		//  ``Message: "My error msg"``
		//  ``Error code: FileError.EXIST = 2``
		//  ``FileErrors identification: 51``
		stdout.printf ("Message: \"%s\"\n", e.message);
		stdout.printf ("Error code: FileError.EXIST = %d\n", e.code);
		stdout.printf ("FileErrors identification: %" + uint32.FORMAT + "\n", e.domain);
		return 0;
	}
	assert_not_reached ();
}
