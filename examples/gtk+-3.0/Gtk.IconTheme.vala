public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.IconTheme";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// Add a button 
		Gtk.Button button = new Gtk.Button ();
		this.add (button);

		// Get the icon:
		Gtk.IconTheme icon_theme = Gtk.IconTheme.get_default ();
		try {
			Gdk.Pixbuf icon = icon_theme.load_icon ("go-home", 48, 0);
			button.image = new Gtk.Image.from_pixbuf (icon);
		} catch (Error e) {
			warning (e.message);
		}
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
