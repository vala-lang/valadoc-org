public static int main (string[] args) {
	try {
		// Create a session:
		Soup.Session session = new Soup.Session ();

		// Request a file:
		Soup.Request request = session.request ("http://api.valadoc.org/soup-samples/my-secret.txt");
		InputStream stream = request.send ();

		// Print the content:
	    DataInputStream data_stream = new DataInputStream (stream);

		string? line;
		while ((line = data_stream.read_line ()) != null) {
			print (line);
			print ("\n");
		}
	} catch (Error e) {
		stderr.printf ("Error: %s\n", e.message);
	}
	return 0;
}
