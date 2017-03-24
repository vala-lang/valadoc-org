public static void http_request (InetSocketAddress socket_address, string host) {
	try {
		// Connect:
		SocketClient client = new SocketClient ();
		SocketConnection conn = client.connect (socket_address);

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
	// Example 1:
	InetAddress address1 = new InetAddress.from_bytes ({208, 80, 152, 201}, SocketFamily.IPV4);
	InetSocketAddress socket_address1 = new InetSocketAddress (address1, 80);
	http_request (socket_address1, "www.wikipedia.org");


	// Example 2:
	InetAddress address2 = new InetAddress.from_string ("208.80.152.201");
	InetSocketAddress socket_address2 = new InetSocketAddress (address2, 80);
	http_request (socket_address2, "www.wikipedia.org");


	// Example 3:
	try {
		Resolver resolver = Resolver.get_default ();
		List<InetAddress> addresses = resolver.lookup_by_name ("www.valadoc.org", null);
		foreach (InetAddress address3 in addresses) {
			InetSocketAddress socket_address3 = new InetSocketAddress (address2, 80);
			http_request (socket_address3, "www.valadoc.org");
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
