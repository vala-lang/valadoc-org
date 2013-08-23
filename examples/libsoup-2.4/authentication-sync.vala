public static int main (string[] args) {
	// Create a session:
	Soup.SessionSync session = new Soup.SessionSync ();

	// Register authentication handler:
	int counter = 0;
	session.authenticate.connect ((msg, auth, retrying) => {
		if (counter < 3) {
			if (retrying == true) {
				stdout.puts ("Invalid user name or password.\n");
			}

			stdout.puts ("Username: ");
			string username = stdin.read_line ();

			stdout.puts ("Password: ");
			string passwd = stdin.read_line ();

			auth.authenticate (username, passwd);
			counter++;
		}
	}); 


	stdout.puts ("URL: ");
	string url = stdin.read_line ();

	// Send a request:
	Soup.Message msg = new Soup.Message ("GET", url);
	if (msg == null) {
		stdout.printf ("Invalid URL\n");
		return 0;
	}

	session.send_message (msg);

	// Process the result:
	stdout.printf ("Status Code: %u\n", msg.status_code);
	return 0;
}
