public static int main (string[] args) {
	MainLoop loop = new MainLoop ();


	print ("URL: ");
	string url = stdin.read_line ();

	print ("Username: ");
	string username = stdin.read_line ();

	print ("Password: ");
	string passwd = stdin.read_line ();


	// Create a session:
	Soup.Session session = new Soup.Session ();

	// Register authentication handler:
	session.authenticate.connect ((msg, auth, retrying) => {
		if (retrying == false) {
			print ("Start authetnication:\n");

			// Simulate asynchronous input / time consuming operations:
			// See GLib.IOSchedulerJob for time consuming operations
			Timeout.add_seconds (10, () => {
				print ("Authentication\n");
				auth.authenticate (username, passwd);

				// Resumes HTTP I/O on msg:
				session.unpause_message (msg);
				return false;
			}, Priority.DEFAULT);

			// Pauses HTTP I/O on msg:
			session.pause_message (msg);
		}
	});

	// Send a request:
	Soup.Message msg = new Soup.Message ("GET", url);
	if (msg == null) {
		print ("Invalid URL\n");
		return 0;
	}

	session.queue_message (msg, (sess, mess) => {
		// Process the result:
		print ("Status Code: %u\n", mess.status_code);
		loop.quit ();
	});

	loop.run ();
	return 0;
}
