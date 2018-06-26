public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	// Create a session:
	Soup.Session session = new Soup.Session ();

	// Send a request:
	Soup.Message msg = new Soup.Message ("GET", "http://gnome.org/");
	session.queue_message (msg, (sess, mess) => {
		// Process the result:
		print ("Status Code: %u\n", mess.status_code);
		print ("Message length: %lld\n", mess.response_body.length);
		print ("Data: \n%s\n", (string) mess.response_body.data);
		loop.quit ();
	});

	loop.run ();
	return 0;
}
