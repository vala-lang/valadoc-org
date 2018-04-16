public static int main (string[] args) {
	string escaped1 = "foo%2Fmy%20ressource.txt";
	string escaped2 = "foo/my%20ressource.txt";


	// Output: ``Unescaped: "(null)"``
	string fragment = Uri.unescape_string (escaped1, "/");
	print ("Unescaped: \"%s\"\n", fragment);

	// Output: ``Unescaped: "foo/my ressource.txt"``
	fragment = Uri.unescape_string (escaped1);
	print ("Unescaped: \"%s\"\n", fragment);

	// Output: ``Unescaped: "foo/my ressource.txt"``
	fragment = Uri.unescape_string (escaped2);
	print ("Unescaped: \"%s\"\n", fragment);

	return 0;
}
