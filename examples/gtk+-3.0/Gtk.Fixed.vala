public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Fixed";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Fixed:
		Gtk.Fixed fixed = new Gtk.Fixed ();
		this.add (fixed);

		Gtk.Button button1 = new Gtk.Button.with_label ("Foo");
		fixed.put (button1, 0, 0);

		Gtk.Button button2 = new Gtk.Button.with_label ("Bar");
		fixed.put (button2, 50, 50);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
