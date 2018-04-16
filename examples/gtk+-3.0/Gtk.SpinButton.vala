public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.SpinButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.SpinButton button = new Gtk.SpinButton.with_range (0, 10, 1);
		this.add (button);

		// Catch changes:
		button.value_changed.connect (() => {
			int val = button.get_value_as_int ();
			print ("%d\n", val);
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
