public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Box";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Box:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		box.pack_start (new Gtk.Label ("1"), false, false, 0);
		box.pack_start (new Gtk.Label ("2"), false, false, 0);
		box.pack_start (new Gtk.Label ("3"), true, false, 0);
		this.add (box);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
