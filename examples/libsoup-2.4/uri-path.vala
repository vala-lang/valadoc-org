public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``Path: /foo/bar.html``
	unowned string path = uri.get_path ();
	print ("Path: %s\n", path);

	// Output: ``URI: http://username@localhost:8088/my/new/path.html?foo=f&bar=b#frag``
	uri.set_path ("/my/new/path.html");
	string uri_str = uri.to_string (false); 
	print ("URI: %s\n", uri_str);

	return 0;
}
