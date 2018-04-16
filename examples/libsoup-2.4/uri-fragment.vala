public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``Fragment: frag``
	unowned string fragment = uri.get_fragment ();
	print ("Fragment: %s\n", fragment);

	// Output: ``URI: http://username@localhost:8088/foo/bar.html?foo=f&bar=b#fragment``
	uri.set_fragment ("fragment");
	string uri_str = uri.to_string (false); 
	print ("URI: %s\n", uri_str);

	return 0;
}
