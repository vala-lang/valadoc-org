public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``Host: localhost``
	unowned string host = uri.get_host ();
	print ("Host: %s\n", host);

	// Output: ``URI: http://username@valadoc.org:8088/foo/bar.html?foo=f&bar=b#frag``
	uri.set_host ("valadoc.org");
	string uri_str = uri.to_string (false); 
	print ("URI: %s\n", uri_str);

	return 0;
}
