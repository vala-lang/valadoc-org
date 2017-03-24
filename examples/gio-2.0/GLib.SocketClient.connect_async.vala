public class AsyncDemo : Object {
	private MainLoop loop;

	public AsyncDemo (MainLoop loop) {
		this.loop = loop;
	}

	public async void http_request () throws Error {
		try {
			// Resolve hostname to IP address:
			Resolver resolver = Resolver.get_default ();
			List<InetAddress> addresses = yield resolver.lookup_by_name_async ("www.google.com");
			InetAddress address = addresses.nth_data (0);
			print ("Resolved www.google.com to %s\n", address.to_string ());

			// Connect:
			InetSocketAddress socket_address = new InetSocketAddress (address, 80);
			SocketClient client = new SocketClient ();
			SocketConnection conn = yield client.connect_async (socket_address);
			print ("Connected to www.google.com\n");

			// Send HTTP GET request
			string message = "GET / HTTP/1.1\r\nHost: www.google.com\r\n\r\n";
			yield conn.output_stream.write_async (message.data, Priority.DEFAULT);
			print ("Wrote request\n");

			// Receive response
			DataInputStream input = new DataInputStream (conn.input_stream);
			message = yield input.read_line_async ();
			print ("Received status line: %s\n", message._strip ());
		} catch (Error e) {
			stderr.printf ("%s\n", e.message);
		}

		this.loop.quit ();
	}
}

void main () {
	var loop = new MainLoop ();
	var demo = new AsyncDemo (loop);
	demo.http_request.begin ();
	loop.run ();
}
