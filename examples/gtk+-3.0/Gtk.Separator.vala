public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Separator";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The button:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 1);
		this.add (box);

		// Dummy content:
		Gtk.Label label1 = new Gtk.Label ("Label 1");
		box.pack_start (label1, true, true, 0);

		// Separator:
		Gtk.Separator separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
		box.pack_start (separator, true, true, 0);

		// Dummy content:
		Gtk.Label label2 = new Gtk.Label ("Label 2");
		box.pack_start (label2, true, true, 0);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
