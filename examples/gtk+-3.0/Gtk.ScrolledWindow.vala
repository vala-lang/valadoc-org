public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ScrolledWindow";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (400, 400);

		// The ScrolledWindow:
		Gtk.ScrolledWindow scrolled = new Gtk.ScrolledWindow (null, null);
		this.add (scrolled);

		// The ScrolledWindow content:
		Gtk.TextView view = new Gtk.TextView ();
		scrolled.add (view);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
