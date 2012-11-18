public class Application : Gtk.Window {
	private int click_counter = 1;

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ToggleButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.ToggleButton button = new Gtk.ToggleButton.with_label ("Click me (1)");
		this.add (button);

		// Set button to "avtive":
		button.set_active (true);


		button.toggled.connect (() => {
			// Emitted when the button has been activated:
			if (button.active) {
				this.click_counter++;
			} else {
				this.click_counter--;
			}

			button.label = "Click me (%d)".printf (this.click_counter);
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
