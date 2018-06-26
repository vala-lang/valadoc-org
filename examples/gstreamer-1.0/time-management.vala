// See http://docs.gstreamer.com/x/cAAF
// for a detailed description

public class Main {

	// TODO: GST_CLOCK_TIME_IS_VALID(time) isn't bound (Tue Aug 20, 2013)
	private static inline bool GST_CLOCK_TIME_IS_VALID (Gst.ClockTime time) {
		return ((time) != Gst.CLOCK_TIME_NONE);
	}

	// Our one and only element
	private Gst.Element playbin2;

	// Are we in the PLAYING state?
	private bool playing;

	// Should we terminate execution?
	private bool terminate;

	// Is seeking enabled for this media?
	private bool seek_enabled;

	// Have we performed the seek already?
	private bool seek_done;

	// How long does this media last, in nanoseconds
	private Gst.ClockTime duration;


	// Forward definition of the message processing function
	private void handle_message (Gst.Message msg) {
		switch (msg.type) {
		case Gst.MessageType.ERROR:
			GLib.Error err;
			string debug_info;

			msg.parse_error (out err, out debug_info);
			print ("Error received from element %s: %s\n", msg.src.name, err.message);
			print ("Debugging information: %s\n", (debug_info != null)? debug_info : "none");
			this.terminate = true;
			break;

		case Gst.MessageType.EOS:
			print ("End-Of-Stream reached.\n");
			this.terminate = true;
			break;

		case Gst.MessageType.DURATION_CHANGED :
			// The duration has changed, mark the current one as invalid:
			this.duration = Gst.CLOCK_TIME_NONE;
			break;

		case Gst.MessageType.STATE_CHANGED:
			Gst.State old_state;
			Gst.State new_state;
			Gst.State pending_state;

			msg.parse_state_changed (out old_state, out new_state, out pending_state);
			if (msg.src == this.playbin2) {
				print ("Pipeline state changed from %s to %s:\n",
					Gst.Element.state_get_name (old_state),
					Gst.Element.state_get_name (new_state));

				// Remember whether we are in the PLAYING state or not:
				this.playing = (new_state == Gst.State.PLAYING);

				if (this.playing) {
					// We just moved to PLAYING. Check if seeking is possible:
					Gst.Query query = new Gst.Query.seeking (Gst.Format.TIME);
					int64 start;
					int64 end;

					if (this.playbin2.query (query)) {
						query.parse_seeking (null, out this.seek_enabled, out start, out end);
						if (this.seek_enabled) {
							// GST_TIME_ARGS isn't available (Tue Aug 20, 2013)
							//print ("Seeking is ENABLED from %" GST_TIME_FORMAT " to %" GST_TIME_FORMAT "\n",
							//		GST_TIME_ARGS (start), GST_TIME_ARGS (end));
							print ("Seeking is ENABLED from %" + int64.FORMAT + " to %" + int64.FORMAT + "\n", start, end);
						} else {
							print ("Seeking is DISABLED for this stream.\n");
						}
					} else {
						print ("Seeking query failed.\n");
					}
				}
			}
			break;

		default:
			// We should not reach here:
			assert_not_reached ();
		}
	}


	public int run () {
		// init:
		this.playing = false;
		this.terminate = false;
		this.seek_enabled = false;
		this.seek_done = false;
		this.duration = Gst.CLOCK_TIME_NONE;

		// Create the elements:
		this.playbin2 = Gst.ElementFactory.make ("playbin", "playbin");

		if (this.playbin2 == null) {
			print ("Not all elements could be created.\n");
			return -1;
		}

		// Set the URI to play:
		this.playbin2.set ("uri", "http://docs.gstreamer.com/media/sintel_trailer-480p.webm");

		// Start playing:
		Gst.StateChangeReturn ret = this.playbin2.set_state (Gst.State.PLAYING);
		if (ret == Gst.StateChangeReturn.FAILURE) {
			stderr.puts ("Unable to set the pipeline to the playing state.\n");
			this.playbin2 = null;
			return -1;
		}

		// Listen to the bus:
		Gst.Bus bus = this.playbin2.get_bus ();
		do {
			Gst.Message msg = bus.timed_pop_filtered (100 * Gst.MSECOND,
				Gst.MessageType.STATE_CHANGED | Gst.MessageType.ERROR | Gst.MessageType.EOS | Gst.MessageType.DURATION_CHANGED);

			// Parse message:
			if (msg != null) {
				handle_message (msg);
			} else {
				// We got no message, this means the timeout expired:
				if (this.playing) {
					Gst.Format fmt = Gst.Format.TIME;
					int64 current = -1;

					// Query the current position of the stream:
					if (!this.playbin2.query_position (fmt, out current)) {
						stderr.puts ("Could not query current position.\n");
					}

					// If we didn't know it yet, query the stream duration:
					if (!GST_CLOCK_TIME_IS_VALID (this.duration)) {
						if (!this.playbin2.query_duration (fmt, out this.duration)) {
							stderr.puts ("Could not query current duration.\n");
						}
					}

					// Print current position and total duration:
					// GST_TIME_ARGS isn't available (Tue Aug 20, 2013)
					// print ("Position %" + Gst.TIME_FORMAT + " / %" + Gst.TIME_FORMAT + "\r",
					//  GST_TIME_ARGS (current), GST_TIME_ARGS (this.duration));
					print ("Position %" + int64.FORMAT + " / %" + int64.FORMAT + "\r",
						current, this.duration);

					// If seeking is enabled, we have not done it yet, and the time is right, seek:
					if (this.seek_enabled && !this.seek_done && current > 10 * Gst.SECOND) {
						print ("\nReached 10s, performing seek...\n");
						this.playbin2.seek_simple (Gst.Format.TIME, Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 30 * Gst.SECOND);
						this.seek_done = true;
					}
				}
			}
		} while (!this.terminate);

		// Free resources:
		this.playbin2.set_state (Gst.State.NULL);
		this.playbin2 = null;

		return 0;
	}

	public static int main (string[] args) {
		// Initialize GStreamer:
		Gst.init (ref args);

		return new Main ().run ();
	}
}
