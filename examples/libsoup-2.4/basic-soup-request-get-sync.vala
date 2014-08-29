public static int main (string[] args) {
	// Create a session:
	Soup.Session session = new Soup.Session ();

	// Add a logger:
	Soup.Logger logger = new Soup.Logger (Soup.LoggerLogLevel.MINIMAL, -1);	
	session.add_feature (logger);

	// Send a request:
	Soup.Message msg = new Soup.Message ("GET", "http://gnome.org/");
	session.send_message (msg);

	// Process the result:
    msg.response_headers.foreach ((name, val) => {
        stdout.printf ("%s = %s\n", name, val);
    });

	stdout.printf ("Status Code: %u\n", msg.status_code);
	stdout.printf ("Message length: %lld\n", msg.response_body.length);
    stdout.printf ("Data: \n%s\n", (string) msg.response_body.data);
	return 0;
}
