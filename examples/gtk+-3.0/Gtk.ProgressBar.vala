public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ProgressBar";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The ProgressBar:
		Gtk.ProgressBar bar = new Gtk.ProgressBar ();
		this.add (bar);

		// Display text:
		bar.set_text ("My progress");
		bar.set_show_text (true);

		// Fill the bar:
		GLib.Timeout.add (500, () => {
			// Get the current progress:
			// (0.0 -> 0%; 1.0 -> 100%)
			double progress = bar.get_fraction ();

			// Update the bar:
			progress = progress + 0.2;
			bar.set_fraction (progress);

			// Repeat until 100%
			return progress < 1.0;
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
