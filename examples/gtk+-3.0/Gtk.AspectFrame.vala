public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.AspectFrame";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The AspectFrame:
		Gtk.AspectFrame frame = new Gtk.AspectFrame ("Label", 0.5f, 0.5f, 1.0f, false);
		this.add (frame);

		// AspectFrame content:
		Gtk.Button button = new Gtk.Button.with_label ("My Button");
		frame.add (button);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
