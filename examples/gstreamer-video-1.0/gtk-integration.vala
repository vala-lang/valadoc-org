public int main (string[] args) {
	Gtk.init (ref args);
	Gst.init (ref args);

	if (args.length != 2) {
		stdout.printf ("% [VIDEO]\n", args[0]);
		return 0;
	}

	var win = new Gtk.Window ();
	uint val = 0;
	uint *handle = &val;
	win.realize.connect (() => {
		handle = (uint*) Gdk.X11.Window.get_xid (win.get_window ());

unowned Gdk.X11.Window x11window = lookup_for_display (Gdk.X11.Display display, X.Window window);
handle = (uint*) x11window.get_xid ();


	});
	var e = Gst.ElementFactory.make ("playbin","playbin");
	e.bus.add_watch(0,(bus,message) => {
		if(Gst.Video.is_video_overlay_prepare_window_handle_message (message)) {
			Gst.Video.Overlay overlay = message.src as Gst.Video.Overlay;
			assert (overlay != null);

			overlay.set_window_handle (handle);
		}
		return true;
	});
	e["uri"] = args[1];
	e.set_state (Gst.State.PLAYING);
	win.destroy.connect (Gtk.main_quit);
	win.show_all ();

	Gtk.main ();
	return 0;
}
