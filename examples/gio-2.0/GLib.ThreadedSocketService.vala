public class Source : Object {
	public uint16 port { private set; get; }

	public Source (uint16 port) {
		this.port = port;
	}
}

public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	// Create a new SocketService:
	ThreadedSocketService service = new ThreadedSocketService (10);

	try {
		// Listen on port 1024 and 1025.
		// Source is used as source-identifier.
		service.add_inet_port (1024, new Source (1024));
		service.add_inet_port (1025, new Source (1025));
	} catch (Error e) {
		print ("Error: %s\n", e.message);
		return 0;
	}

	// Used to shutdown the program:
	Cancellable cancellable = new Cancellable ();
	cancellable.cancelled.connect (() => {
		service.stop ();
		loop.quit ();
	});

	// The run signal is emitted in a worker thread:
	service.run.connect ((connection, source_object) => {
		try {
			Source source = source_object as Source;
			print ("Accepted! (Source: %d)\n", source.port);

			DataInputStream istream = new DataInputStream (connection.input_stream);
			DataOutputStream ostream = new DataOutputStream (connection.output_stream);

			// Get the received message:
			string message = istream.read_line (null, cancellable);
			message._strip ();
			print ("Received: %s\n", message);

			// Response:
			ostream.put_string (message, cancellable);
			ostream.put_byte ('\n', cancellable);

			if (message == "shutdown") {
				cancellable.cancel ();
				return true;
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}
		return false;
	});

	service.start ();
	loop.run ();
	return 0;
}
