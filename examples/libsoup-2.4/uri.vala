public static int main (string[] args) {
	Soup.URI uri = new Soup.URI ("http://username:password@localhost:8088/foo/bar.html?foo=f&bar=b#frag");

	// Output: ``Fragment: frag``
	unowned string fragment = uri.get_fragment ();
	stdout.printf ("Fragment: %s\n", fragment);

	// Output: ``Host: localhost``
	unowned string host = uri.get_host ();
	stdout.printf ("Host: %s\n", host);

	// Output: ``Password: password``
	unowned string passwd = uri.get_password ();
	stdout.printf ("Password: %s\n", passwd);

	// Output: ``Path: /foo/bar.html``
	unowned string path = uri.get_path ();
	stdout.printf ("Path: %s\n", path);

	// Output: ``Port: 8088``
	uint port = uri.get_port ();
	stdout.printf ("Port: %u\n", port);

	// Output: ``Query: foo=f&bar=b``
	unowned string query = uri.get_query ();
	stdout.printf ("Query: %s\n", query);

	// Output: ``Scheme: http``
	unowned string scheme = uri.get_scheme ();
	stdout.printf ("Scheme: %s\n", scheme);

	// Output: ``User: username``
	unowned string user = uri.get_user ();
	stdout.printf ("User: %s\n", user);

	return 0;
}
