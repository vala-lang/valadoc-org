public class Application : Gtk.Window {
	public Application (string filename) {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Viewport";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (200, 200);

		// ScrolledWindow:
		Gtk.ScrolledWindow scrolled = new Gtk.ScrolledWindow (null, null);
		this.add (scrolled);

		// The Viewport:
		Gtk.Viewport viewport = new Gtk.Viewport (null, null);
		viewport.set_size_request (200, 200);
		scrolled.add (viewport);

		// A Pixbuf:
		Gtk.Image img = new Gtk.Image.from_file (filename);
		viewport.add (img);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		if (args[1] == null) {
			print ("Error: Use `./Gtk.Viewport <image-path>`\n");
			return 0;
		}

		Application app = new Application (args[1]);
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
