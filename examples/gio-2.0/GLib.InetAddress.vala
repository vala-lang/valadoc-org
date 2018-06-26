public static int main (string[] args) {
	Resolver resolver = Resolver.get_default ();

	// Example 1:
	InetAddress address1 = new InetAddress.from_bytes ({208, 80, 152, 201}, SocketFamily.IPV4);

	try {
		// Output: ``wikipedia-lb.pmtpa.wikimedia.org`` (Wed Oct 24, 20012)
		string hostname = resolver.lookup_by_address (address1, null);
		print ("host: %s\n", hostname);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}


	// Example 2:
	InetAddress address2 = new InetAddress.from_string ("208.80.152.201");

	try {
		// Output: ``wikipedia-lb.pmtpa.wikimedia.org`` (Wed Oct 24, 20012)
		string hostname = resolver.lookup_by_address (address2, null);
		print ("host: %s\n", hostname);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}


	// Example 3:
	try {
		// Resolve hostname to IP address:
		string host = "www.valadoc.org";
		List<InetAddress> addresses = resolver.lookup_by_name (host, null);
		InetAddress address4 = addresses.nth_data (0);

		// Connect:
		SocketClient client = new SocketClient ();
		SocketConnection conn = client.connect (new InetSocketAddress (address4, 80));

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

	return 0;
}
