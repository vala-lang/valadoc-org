private static async void read_lines_async (InputStream stream) throws IOError {
	DataInputStream data_stream = new DataInputStream (stream);
	string line;

	while ((line = yield data_stream.read_line_async ()) != null) {
		print (line);
		print ("\n");
	}
}

public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	// Create a session:
	Soup.Session session = new Soup.Session ();
	session.use_thread_context = true;

	// Request a file:
	try {
		Soup.Request request = session.request ("http://api.valadoc.org/soup-samples/my-secret.txt");
		request.send_async.begin (null, (obj, res) => {
			// print the content:
			try {
				InputStream stream = request.send_async.end (res);
				read_lines_async.begin (stream, (obj, res) => {
					// Exit
					loop.quit ();
				});
			} catch (Error e) {
				stderr.printf ("Error: %s\n", e.message);
			}
		});
	} catch (Error e) {
		stderr.printf ("Error: %s\n", e.message);
	}

	loop.run ();
	return 0;
}
