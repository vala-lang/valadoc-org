public static int main (string[] args) {
	// Create a session:
	Soup.Session session = new Soup.Session ();

	// Register authentication handler:
	int counter = 0;
	session.authenticate.connect ((msg, auth, retrying) => {
		if (counter < 3) {
			if (retrying == true) {
				print ("Invalid user name or password.\n");
			}

			print ("Username: ");
			string username = stdin.read_line ();

			print ("Password: ");
			string passwd = stdin.read_line ();

			auth.authenticate (username, passwd);
			counter++;
		}
	}); 


	print ("URL: ");
	string url = stdin.read_line ();

	// Send a request:
	Soup.Message msg = new Soup.Message ("GET", url);
	if (msg == null) {
		print ("Invalid URL\n");
		return 0;
	}

	session.send_message (msg);

	// Process the result:
	print ("Status Code: %u\n", msg.status_code);
	return 0;
}
