public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Table";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Table:
		Gtk.AttachOptions flags = Gtk.AttachOptions.EXPAND | Gtk.AttachOptions.FILL;
		Gtk.Table table = new Gtk.Table (3, 3, true);
		table.attach(new Gtk.Label ("1"), 0, 1, 0, 1, flags, flags, 0, 0);
		table.attach(new Gtk.Label ("2"), 1, 3, 0, 1, flags, flags, 0, 0);
		table.attach(new Gtk.Label ("3"), 0, 1, 1, 3, flags, flags, 0, 0);
		table.attach(new Gtk.Label ("4"), 1, 3, 1, 3, flags, flags, 0, 0);
		this.add (table);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
