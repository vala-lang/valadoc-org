public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Expander";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Expander:
		Gtk.Expander expander = new Gtk.Expander ("<b>My secret area</b>");
		expander.use_markup = true;
		this.add (expander);

		// Expander content:
		Gtk.Label label = new Gtk.Label ("You found me!");
		expander.add (label);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
