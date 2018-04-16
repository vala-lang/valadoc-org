public static int main (string[] args) {
	// Create a session:
	Soup.Session session = new Soup.Session ();

	// Add a logger:
	Soup.Logger logger = new Soup.Logger (Soup.LoggerLogLevel.MINIMAL, -1);	
	session.add_feature (logger);

	// Create a cookie:
	Soup.Cookie cookie = new Soup.Cookie ("soup-cookie", "my-val", "api.valadoc.org", "/", -1);
	SList<Soup.Cookie> list = new SList<Soup.Cookie> ();
	list.append (cookie);

	// Send a request:
	Soup.Message msg = new Soup.Message ("GET", "http://api.valadoc.org/soup-samples/print-and-create-cookies.php");
	Soup.cookies_to_request (list, msg);
	session.send_message (msg);

	// Process the result:
    msg.response_headers.foreach ((name, val) => {
        print ("%s = %s\n", name, val);
    });

	print ("Status Code: %u\n", msg.status_code);
	print ("Message length: %lld\n", msg.response_body.length);
    print ("Data: \n%s\n", (string) msg.response_body.data);

	GLib.SList<Soup.Cookie> cookies = Soup.cookies_from_request (msg);
	print ("Cookies from request: (%u)\n", cookies.length ());

	foreach (Soup.Cookie c in cookies) {
		print ("  %s: %s\n", c.name, c.value);
	}

	cookies = Soup.cookies_from_response (msg);
	print ("Cookies from response: (%u)\n", cookies.length ());

	foreach (Soup.Cookie c in cookies) {
		print ("  %s: %s\n", c.name, c.value);
	}

	return 0;
}
