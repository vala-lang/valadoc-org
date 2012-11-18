public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ColorButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.ColorButton button = new Gtk.ColorButton ();

		// Use alpha channel
		button.set_use_alpha (true);

		// Set value to blue:
		Gdk.Color color;
		bool tmp = Gdk.Color.parse ("#0066FF", out color);
		assert (tmp == true);
		button.set_color (color);

		// Sets the title for the color selection dialog:
		button.set_title ("Select your favourite color");

		// Catch color-changes:
		button.color_set.connect (() => {
			button.get_color (out color);
			uint16 alpha = button.get_alpha ();
			stdout.printf ("%s, %hu\n", color.to_string (), alpha);
		});
		this.add (button);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
