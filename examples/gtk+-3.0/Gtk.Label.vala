public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Label";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Label:
		Gtk.Label label = new Gtk.Label ("<b>Hello, world!</b>");
		label.set_use_markup (true);
		label.set_line_wrap (true);
		this.add (label);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
