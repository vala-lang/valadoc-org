public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.LevelBar";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The ProgressBar:
		Gtk.LevelBar bar = new Gtk.LevelBar.for_interval (0.0, 10.0);
		bar.set_mode (Gtk.LevelBarMode.DISCRETE);
		bar.set_value (5.0);
		this.add (bar);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
