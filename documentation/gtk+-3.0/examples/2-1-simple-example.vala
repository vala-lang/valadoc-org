
static int main (string[] args) {
	Gtk.init (ref args);

	// The next line creates an empty window.
	var win = new Gtk.Window ();

	// Followed by connecting to the window’s delete
	// event to ensure that the application is
	// terminated if we click on the x to close the
	// window.
	win.destroy.connect (Gtk.main_quit);

	// In the next step we display the window.
	win.show_all ();

	// Finally, we start the GTK+ processing loop
	// which we quit when the window is closed.
	// (Gtk.main_quit)
	Gtk.main ();
	return 0;
}

