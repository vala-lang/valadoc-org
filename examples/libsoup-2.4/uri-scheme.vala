public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``Scheme: http``
	unowned string scheme = uri.get_scheme ();
	print ("Scheme: %s\n", scheme);

	// Output: ``URI: https://username@localhost/foo/bar.html?foo=f&bar=b#frag``
	uri.set_scheme ("https");
	string uri_str = uri.to_string (false); 
	print ("URI: %s\n", uri_str);

	return 0;
}
