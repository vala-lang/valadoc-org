public class Application : Gtk.Window {
	private int click_counter = 0;

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.CheckButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The CheckButton:
		Gtk.CheckButton button = new Gtk.CheckButton.with_label ("Click me (0)");
		this.add (button);

		button.toggled.connect (() => {
			// Emitted when the button has been clicked:
			if (button.active) {
				// Button is checked
				this.click_counter++;
			} else {
				// Button is not checked
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
