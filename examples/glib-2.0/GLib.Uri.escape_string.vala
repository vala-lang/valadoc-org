public static int main (string[] args) {
	string ressource = "foo/my ressource.txt";

	// Output: ``Escaped ressource: "foo%2Fmy%20ressource.txt"``
	string fragment = Uri.escape_string (ressource);
	print ("Escaped ressource: \"%s\"\n", fragment);

	// Output: ``Escaped ressource: "foo/my%20ressource.txt"``
	fragment = Uri.escape_string (ressource, "/");
	print ("Escaped ressource: \"%s\"\n", fragment);

	return 0;
}
