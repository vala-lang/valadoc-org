public class NoodleSoupServer : Soup.Server {
	private int access_counter = 0;

	public NoodleSoupServer () {
		assert (this != null);

		// Links:
		//   http://localhost:8088/*
		this.add_handler (null, default_handler);
	}

	private static void default_handler (Soup.Server server, Soup.Message msg, string path, GLib.HashTable? query, Soup.ClientContext client) {
		unowned NoodleSoupServer self = server as NoodleSoupServer;

		uint id = self.access_counter++;
		print ("Default handler start (%u)\n", id);

		// Simulate asynchronous input / time consuming operations:
		// See GLib.IOSchedulerJob for time consuming operations
		Timeout.add_seconds (0, () => {
			string html_head = "<head><title>Index</title></head>";
			string html_body = "<body><h1>Index:</h1></body>";
			msg.set_response ("text/html", Soup.MemoryUse.COPY, "<html>%s%s</html>".printf (html_head, html_body).data);

			// Resumes HTTP I/O on msg:
			self.unpause_message (msg);
			print ("Default handler end (%u)\n", id);
			return false;
		}, Priority.DEFAULT);

		// Pauses HTTP I/O on msg:
		self.pause_message (msg);
	}

	public static int main (string[] args) {
		try {
			int port = 8088;

			MainLoop loop = new MainLoop ();

			NoodleSoupServer server = new NoodleSoupServer ();
			server.listen_all (port, 0);

			loop.run ();
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}
		return 0;
	}
}
