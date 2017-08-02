public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``http://username@localhost:8088/foo/bar.html?foo=f&bar=b#frag``
	string uri_str1 = uri.to_string (false);
	print ("%s\n", uri_str1);

	// Output: ``/foo/bar.html?foo=f&bar=b``
	string uri_str2 = uri.to_string (true);
	print ("%s\n", uri_str2);

	return 0;
}
