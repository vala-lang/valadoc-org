public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output:
	//  ``Port: 8088``
	//  ``Default: false``
	uint port = uri.get_port ();
	bool default = uri.uses_default_port ();
	print ("Port: %u\n", port);
	print ("Default: %s\n", default.to_string ());


	// Output:
	//  ``URI: http://username@localhost/foo/bar.html?foo=f&bar=b#frag``
	//  ``Default: true``
	uri.set_port (80);
	string uri_str = uri.to_string (false); 
	@default = uri.uses_default_port ();
	print ("URI: %s\n", uri_str);
	print ("Default: %s\n", default.to_string ());

	return 0;
}
