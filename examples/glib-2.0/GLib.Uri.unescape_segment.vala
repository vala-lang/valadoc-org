public static int main (string[] args) {
	string ressource = "foo/my%2F1.%20ressource.txt";
	//					    ^-----------------^
	//                   start             end

	unowned string start = (string) ((char*)ressource + 4);
	unowned string end = (string) ((char*)ressource + 27);

	// Output:
	//  ``start: "my%2F1.%20ressource.txt"``
	//  ``end: ""``
	stdout.printf ("start: \"%s\"\n", start);
	stdout.printf ("end: \"%s\"\n", end);


	// Output: ``Unescaped segment: "my/1. ressource.txt"``
	string? segment = Uri.unescape_segment (start, end);
	stdout.printf ("Unescaped segment: \"%s\"\n", segment);

	// Output: ``Unescaped segment: "(null)"``
	segment = Uri.unescape_segment (start, end, "/");
	stdout.printf ("Unescaped segment: \"%s\"\n", segment);


	// Output: ``Unescaped segment: "(null)"``
	segment = Uri.unescape_segment (null, null);
	stdout.printf ("Unescaped segment: \"%s\"\n", segment);

	return 0;
}
