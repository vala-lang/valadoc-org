public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Arrow";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The button:
		Gtk.Arrow arrow = new Gtk.Arrow (Gtk.ArrowType.LEFT, Gtk.ShadowType.ETCHED_IN);
		this.add (arrow);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
