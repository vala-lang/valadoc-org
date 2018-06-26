// See http://docs.gstreamer.com/x/ZgAF
// for a detailed description

public static int main (string[] args) {

	// Initialize GStreamer:
	Gst.init (ref args);

	// Create the elements:
	Gst.Element source = Gst.ElementFactory.make ("videotestsrc", "source");
	Gst.Element sink = Gst.ElementFactory.make ("autovideosink", "sink");

	// Create the empty pipeline:
	Gst.Pipeline pipeline = new Gst.Pipeline ("test-pipeline");

	if (source == null || sink == null || pipeline == null) {
		stderr.puts ("Not all elements could be created.\n");
		return -1;
	}

	// Build the pipeline:
	pipeline.add_many (source, sink);

	if (source.link (sink) != true) {
		stderr.puts ("Elements could not be linked.\n");
		return -1;
	}

	// Modify the source's properties:
	source.set ("pattern", 0);

	// Start playing:
	Gst.StateChangeReturn ret = pipeline.set_state (Gst.State.PLAYING);
	if (ret == Gst.StateChangeReturn.FAILURE) {
		stderr.puts ("Unable to set the pipeline to the playing state.\n");
		return -1;
	}

	// Wait until error or EOS:
	Gst.Bus bus = pipeline.get_bus ();
	Gst.Message msg = bus.timed_pop_filtered (Gst.CLOCK_TIME_NONE, Gst.MessageType.ERROR | Gst.MessageType.EOS);


	// Parse message:
	if (msg != null) {
		switch (msg.type) {
		case Gst.MessageType.ERROR:
			GLib.Error err;
			string debug_info;

			msg.parse_error (out err, out debug_info);
			stderr.printf ("Error received from element %s: %s\n", msg.src.name, err.message);
			stderr.printf ("Debugging information: %s\n", (debug_info != null)? debug_info : "none");
			break;

		case Gst.MessageType.EOS:
			print ("End-Of-Stream reached.\n");
			break;

		default:
			// We should not reach here because we only asked for ERRORs and EOS:
			assert_not_reached ();
		}
	}


	// Free resources:
	pipeline.set_state (Gst.State.NULL);

	return 0;
}
