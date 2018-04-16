// See http://docs.gstreamer.com/x/aAAF
// for a detailed description

public class Main {
	private Gst.Pipeline pipeline;
	private Gst.Element source;
	private Gst.Element convert;
	private Gst.Element sink;

	//
	// Handler for the pad-added signal.
	//
	// This function will be called by the pad-added signal.
	//
	private void pad_added_handler (Gst.Element src, Gst.Pad new_pad) {
		Gst.Pad sink_pad = this.convert.get_static_pad ("sink");
		print ("Received new pad '%s' from '%s':\n", new_pad.name, src.name);

		// If our converter is already linked, we have nothing to do here:
		if (sink_pad.is_linked ()) {
			print ("  We are already linked. Ignoring.\n");
			return ;
		}

		// Check the new pad's type:
		Gst.Caps new_pad_caps = new_pad.query_caps (null);
		weak Gst.Structure new_pad_struct = new_pad_caps.get_structure (0);
		string new_pad_type = new_pad_struct.get_name ();
		if (!new_pad_type.has_prefix ("audio/x-raw")) {
			print ("  It has type '%s' which is not raw audio. Ignoring.\n", new_pad_type);
			return ;
		}

		// Attempt the link:
		Gst.PadLinkReturn ret = new_pad.link (sink_pad);
		if (ret != Gst.PadLinkReturn.OK) {
			print ("  Type is '%s' but link failed.\n", new_pad_type);
		} else {
			print ("  Link succeeded (type '%s').\n", new_pad_type);
		}
	}

	//
	// Example runner
	//
	public int run () {
		// Create the elements:
		this.source = Gst.ElementFactory.make ("uridecodebin", "source");
		this.convert = Gst.ElementFactory.make ("audioconvert", "convert");
		this.sink = Gst.ElementFactory.make ("autoaudiosink", "sink");

		// Create the empty pipeline:
		this.pipeline = new Gst.Pipeline ("test-pipeline");

		if (this.pipeline == null || this.source == null || this.convert == null || this.sink == null) {
			print ("Not all elements could be created.\n");
			return -1;
		}

		// Build the pipeline. Note that we are NOT linking the source at this
		// point. We will do it later.

		this.pipeline.add_many (this.source, this.convert , this.sink);
		if (!this.convert.link (this.sink)) {
			print ("Elements could not be linked.\n");
			return -1;
		}

		// Set the URI to play:
		this.source.set ("uri", "http://docs.gstreamer.com/media/sintel_trailer-480p.webm");

		// Connect to the pad-added signal:
		this.source.pad_added.connect (pad_added_handler);

		// Start playing:
		Gst.StateChangeReturn ret = this.pipeline.set_state (Gst.State.PLAYING);
		if (ret == Gst.StateChangeReturn.FAILURE) {
			stderr.puts ("Unable to set the pipeline to the playing state.\n");
			return -1;
		}

		// Listen to the bus:
		Gst.Bus bus = this.pipeline.get_bus ();
		bool terminate = false;
		do {
			Gst.Message msg = bus.timed_pop_filtered (Gst.CLOCK_TIME_NONE,
				Gst.MessageType.STATE_CHANGED | Gst.MessageType.ERROR | Gst.MessageType.EOS);

			// Parse message:
			if (msg != null) {
				switch (msg.type) {
				case Gst.MessageType.ERROR:
					GLib.Error err;
					string debug_info;

					msg.parse_error (out err, out debug_info);
					stderr.printf ("Error received from element %s: %s\n", msg.src.name, err.message);
					stderr.printf ("Debugging information: %s\n", (debug_info != null)? debug_info : "none");
					terminate = true;
					break;

				case Gst.MessageType.EOS:
					print ("End-Of-Stream reached.\n");
					terminate = true;
					break;

				case Gst.MessageType.STATE_CHANGED:
					// We are only interested in state-changed messages from the pipeline:
					if (msg.src == this.pipeline) {
						Gst.State old_state;
						Gst.State new_state;
						Gst.State pending_state;

						msg.parse_state_changed (out old_state, out new_state, out pending_state);
						print ("Pipeline state changed from %s to %s:\n",
							Gst.Element.state_get_name (old_state),
							Gst.Element.state_get_name (new_state));
					}
					break;

				default:
					//We should not reach here:
					assert_not_reached ();
				}
			}
		} while (!terminate);

		// Free resources:
		bus = null;
		this.pipeline.set_state (Gst.State.NULL);
		this.pipeline = null;

		return 0;
	}

	public static int main (string[] args) {
		// Initialize GStreamer:
		Gst.init (ref args);

		// Run the example:
		return new Main ().run ();
	}
}
