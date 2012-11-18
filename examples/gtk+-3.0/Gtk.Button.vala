public class Application : Gtk.Window {
	private int click_counter = 0;

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Button";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The button:
		Gtk.Button button = new Gtk.Button.with_label ("Click me (0)");
		this.add (button);

		button.clicked.connect (() => {
			// Emitted when the button has been activated:
			button.label = "Click me (%d)".printf (++this.click_counter);
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
