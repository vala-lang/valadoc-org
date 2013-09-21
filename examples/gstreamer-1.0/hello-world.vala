// See http://docs.gstreamer.com/x/NwAF
// for a detailed description

public static int main (string[] args) {
	// Initialize GStreamer:
	Gst.init (ref args);


	// Build the pipeline:
	Gst.Element pipeline;
	try {
		pipeline = Gst.parse_launch ("playbin uri=http://docs.gstreamer.com/media/sintel_trailer-480p.webm");
	} catch (Error e) {
		stderr.printf ("Error: %s\n", e.message);
		return 0;
	}

	// Start playing:
	pipeline.set_state (Gst.State.PLAYING);

	// Wait until error or EOS:
	Gst.Bus bus = pipeline.get_bus ();
	bus.timed_pop_filtered (Gst.CLOCK_TIME_NONE, Gst.MessageType.ERROR | Gst.MessageType.EOS);

	// Free resources:
	pipeline.set_state (Gst.State.NULL);

	return 0;
}
