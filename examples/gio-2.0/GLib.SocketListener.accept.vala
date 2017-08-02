public class Source : Object {
	public uint16 port { private set; get; }

	public Source (uint16 port) {
		this.port = port;
	}
}

public class Worker : Object {
	private SocketConnection connection;
	private Cancellable cancellable;
	private Source source;

	public Worker (SocketConnection connection, Source source, Cancellable cancellable) {
		this.cancellable = cancellable;
		this.connection = connection;
		this.source = source;
	}

	public int run () {
		try {
			print ("Thread started (Port: %d)\n", this.source.port);

			// Wait for a message:
			DataInputStream istream = new DataInputStream (this.connection.input_stream) ;
			string message = istream.read_line (null, this.cancellable);
			print ("Received: %s\n", message);
			stdout.flush ();

			// Response:
			OutputStream ostream = this.connection.output_stream;
			ostream.write (message.data, this.cancellable);
			ostream.write ("\n".data, this.cancellable);

			if (message._strip () == "shutdown") {
				this.cancellable.cancel ();
			}
		} catch (IOError e) {
			print ("IOError: %s\n", e.message);
		}
		return 0;
	}
}

public static int main (string[] args) {
	try {
		SocketListener listener = new SocketListener ();

		// Used to shutdown the program:
		Cancellable cancellable = new Cancellable ();

		// Listen on port 1024 and 1025.
		// Source is used as source-identifier.
		listener.add_inet_port (1024, new Source (1024));
		listener.add_inet_port (1025, new Source (1025));
		SocketConnection? connection = null;
		Object? source = null;

		// Wait for connections:
		while ((connection = listener.accept (out source, cancellable)) != null) {
			// Spawn a thread for each request:
			Worker worker = new Worker (connection, source as Source, cancellable);
			new Thread<int>.try (null, () => { return worker.run (); });
			connection = null;
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
