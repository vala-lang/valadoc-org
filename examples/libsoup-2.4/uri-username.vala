public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``User: username``
	unowned string user = uri.get_user ();
	print ("User: %s\n", user);

	// Output: ``URI: http://me@localhost:8088/foo/bar.html?foo=f&bar=b#frag``
	uri.set_user ("me");
	string uri_str = uri.to_string (false); 
	print ("URI: %s\n", uri_str);

	return 0;
}
