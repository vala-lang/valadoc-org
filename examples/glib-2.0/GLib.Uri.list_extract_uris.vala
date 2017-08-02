public static int main (string[] args) {
	string uri_list = """# comment
       http://example.org/absolute/URI/absolute/path/to/resource1.txt
       http://example.org/absolute/URI/absolute/path/to/resource2.txt

       http://example.org/absolute/URI/absolute/path/to/resource3.txt
""";


	// Output:
	//  ``Uri: http://example.org/absolute/URI/absolute/path/to/resource1.txt``
	//  ``Uri: http://example.org/absolute/URI/absolute/path/to/resource2.txt``
	//  ``Uri: http://example.org/absolute/URI/absolute/path/to/resource3.txt``
	string[] uris = Uri.list_extract_uris (uri_list);
	foreach (string uri in uris) {
		print ("Uri: %s\n", uri);
	}

	return 0;
}
