public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``Password: password``
	unowned string passwd = uri.get_password ();
	print ("Password: %s\n", passwd);

	// Output: ``URI: http://username@localhost:8088/foo/bar.html?foo=f&bar=b#frag``
	uri.set_password ("123");
	string uri_str = uri.to_string (false); 
	print ("URI: %s\n", uri_str);

	return 0;
}
