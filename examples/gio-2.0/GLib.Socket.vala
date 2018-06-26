public static void server (SocketAddress address) throws Error {
	Socket socket = new Socket (SocketFamily.IPV4, SocketType.STREAM, SocketProtocol.TCP);
	assert (socket != null);

	socket.bind (address, true);
	socket.set_listen_backlog (10);
	socket.listen ();

	for (int i = 0; true ; i = (i + 1) % 10) {
		Socket connection = socket.accept ();
		print (@"Accepted ($i)\n");

		connection.send (i.to_string ().data);
	}
}

public static void client (SocketAddress address) throws Error {
	Socket socket = new Socket (SocketFamily.IPV4, SocketType.STREAM, SocketProtocol.TCP);
	assert (socket != null);

	socket.connect (address);
	print ("Connected\n");

	uint8 buffer[100];
	ssize_t len;

	len = socket.receive (buffer);
	stdout.write (buffer, len);
	print ("\n");
}

public static int main (string[] args) {
	try {
		if (args.length != 2) {
			print ("%s server|client\n", args[0]);
			return 0;
		}

		InetAddress address = new InetAddress.loopback (SocketFamily.IPV4);
		InetSocketAddress inetaddress = new InetSocketAddress (address, 2001);

		if (args[1] == "server") {
			server (inetaddress);
		} else if (args[1] == "client") {
			client (inetaddress);
		} else {
			print ("Unknown option.\n");
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
