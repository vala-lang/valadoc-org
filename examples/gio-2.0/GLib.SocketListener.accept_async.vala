public class Server : Object {
	private Cancellable cancellable;

	private class Source : Object {
		public uint16 port { private set; get; }

		public Source (uint16 port) {
			this.port = port;
		}
	}

	private async void worker_func (SocketConnection connection, Source source) {
		try {
			DataInputStream istream = new DataInputStream (connection.input_stream);
			DataOutputStream ostream = new DataOutputStream (connection.output_stream);

			// Get the received message:
			string message = yield istream.read_line_async (Priority.DEFAULT, this.cancellable);
			message._strip ();
			print ("Received: %s\n", message);

			// Response:
			ostream.put_string (message, this.cancellable);
			ostream.put_byte ('\n', this.cancellable);

			if (message == "shutdown") {
				this.cancellable.cancel ();
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}
	}

	public async void listen (Cancellable cancellable) {
		this.cancellable = cancellable;

		try {
			// Listen on port 1024 and 1025.
			// Source is used as source-identifier.
			SocketListener listener = new SocketListener ();
			listener.add_inet_port (1024, new Source (1024));
			listener.add_inet_port (1025, new Source (1025));

			// Wait for connections:
			while (true) {
				// Get the connection:
				Object source_obj;
				SocketConnection connection = yield listener.accept_async (this.cancellable, out source_obj);

				// Identify the source:
				Source source = source_obj as Source;
				assert (source != null);

				print ("Accepted! (Source: %d)\n", source.port);

				// Register a worker:
				worker_func.begin (connection, source);
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}
	}

	public static int main (string[] args) {
		MainLoop loop = new MainLoop ();

		// Used to shutdown the program:
		Cancellable cancellable = new Cancellable ();
		cancellable.cancelled.connect (() => {
			loop.quit ();
		});

		new Server ().listen.begin (cancellable);
		loop.run ();
		return 0;
	}
}
