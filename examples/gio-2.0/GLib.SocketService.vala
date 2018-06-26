public class Source : Object {
	public uint16 port { private set; get; }

	public Source (uint16 port) {
		this.port = port;
	}
}

public async void worker_func (SocketConnection connection, Source source, Cancellable cancellable) {
	try {
		DataInputStream istream = new DataInputStream (connection.input_stream);
		DataOutputStream ostream = new DataOutputStream (connection.output_stream);

		// Get the received message:
		string message = yield istream.read_line_async (Priority.DEFAULT, cancellable);
		message._strip ();
		print ("Received: %s\n", message);

		// Response:
		ostream.put_string (message, cancellable);
		ostream.put_byte ('\n', cancellable);

		if (message == "shutdown") {
			cancellable.cancel ();
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
}

public static int main (string[] args) {
	try {
		MainLoop loop = new MainLoop ();

		// Create a new SocketService:
		SocketService service = new SocketService ();

		// Listen on port 1024 and 1025.
		// Source is used as source-identifier.
		service.add_inet_port (1024, new Source (1024));
		service.add_inet_port (1025, new Source (1025));

		// Used to shutdown the program:
		Cancellable cancellable = new Cancellable ();
		cancellable.cancelled.connect (() => {
			service.stop ();
			loop.quit ();
		});

		service.incoming.connect ((connection, source_object) => {
			Source source = source_object as Source;

			print ("Accepted! (Source: %d)\n", source.port);
			worker_func.begin (connection, source, cancellable);
			return false;
		});

		service.start ();
		loop.run ();
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
