public static int main (string[] args) {
	string uri = "http://example.org/absolute/URI/with/absolute/path/to/resource.txt";

	// Output: ``Uri scheme: http``
	string scheme = Uri.parse_scheme (uri);
	print ("Uri scheme: %s\n", scheme);
	return 0;
}
