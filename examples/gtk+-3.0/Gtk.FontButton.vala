public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.FontButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.FontButton button = new Gtk.FontButton ();
		this.add (button);

		// Use the selected font & size to draw the button-label:
		button.use_font = true;
		button.use_size = true;

		// Sets the title for the font chooser dialog:
		button.set_title ("Pick your favourite font");

		// Connect a signal:
		button.font_set.connect (() => {
			// Emitted when a font has been chosen:
			unowned string name = button.get_font_name ();
			print ("Selected font: %s\n", name);
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
