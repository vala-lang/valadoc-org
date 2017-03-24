public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ScaleButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		string[] icons = { "zoom-out", "zoom-in" };
		Gtk.ScaleButton button = new Gtk.ScaleButton (Gtk.IconSize.SMALL_TOOLBAR, 0.0, 1.0, 0.2, icons);
		this.add (button);

		// Catch changes:
		button.value_changed.connect ((val) => {
			print ("%f\n", val);
		});
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
