public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.InfoBar";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The InfoBar:
		Gtk.InfoBar bar = new Gtk.InfoBar ();
		this.add (bar);

		// Buttons:
		bar.add_button ("Yes", 1);
		bar.add_button ("No", 2);

		// Content:
		Gtk.Container content = bar.get_content_area ();
		content.add (new Gtk.Label ("My Content"));
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
