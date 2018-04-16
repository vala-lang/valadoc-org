public static void http_get_sync (string host) {
	try {
		// Resolve hostname to IP address:
		Resolver resolver = Resolver.get_default ();
		List<InetAddress> addresses = resolver.lookup_by_name (host, null);
		InetAddress address = addresses.nth_data (0);

		// Connect:
		SocketClient client = new SocketClient ();
		SocketConnection conn = client.connect (new InetSocketAddress (address, 80));

		// Send HTTP GET request
		string message = @"GET / HTTP/1.1\r\nHost: %s\r\n\r\n".printf (host);
		conn.output_stream.write (message.data);

		// Receive response
		DataInputStream response = new DataInputStream (conn.input_stream);
		string status_line = response.read_line (null).strip ();
		print ("Received status line: %s\n", status_line);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
}

public static int main (string[] args) {
	http_get_sync ("www.google.at");
	return 0;
}
