public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Paned";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The Pane:
		Gtk.Paned pane = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
		this.add (pane);

		// Content:
		pane.add1 (new Gtk.Label ("Left"));
		pane.add2 (new Gtk.Label ("Right"));
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
