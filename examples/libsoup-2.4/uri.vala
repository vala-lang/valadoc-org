public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``Fragment: frag``
	unowned string fragment = uri.get_fragment ();
	print ("Fragment: %s\n", fragment);

	// Output: ``Host: localhost``
	unowned string host = uri.get_host ();
	print ("Host: %s\n", host);

	// Output: ``Password: password``
	unowned string passwd = uri.get_password ();
	print ("Password: %s\n", passwd);

	// Output: ``Path: /foo/bar.html``
	unowned string path = uri.get_path ();
	print ("Path: %s\n", path);

	// Output: ``Port: 8088``
	uint port = uri.get_port ();
	print ("Port: %u\n", port);

	// Output: ``Query: foo=f&bar=b``
	unowned string query = uri.get_query ();
	print ("Query: %s\n", query);

	// Output: ``Scheme: http``
	unowned string scheme = uri.get_scheme ();
	print ("Scheme: %s\n", scheme);

	// Output: ``User: username``
	unowned string user = uri.get_user ();
	print ("User: %s\n", user);

	return 0;
}
