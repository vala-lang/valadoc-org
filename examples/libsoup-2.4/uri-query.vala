public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``Query: foo=f&bar=b``
	unowned string query = uri.get_query ();
	print ("Query: %s\n", query);

	// Output: ``URI: http://username@localhost:8088/foo/bar.html?index=main#frag``
	uri.set_query ("index=main");
	string uri_str = uri.to_string (false); 
	print ("URI: %s\n", uri_str);

	return 0;
}
