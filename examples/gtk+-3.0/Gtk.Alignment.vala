public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Alignment";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// Alignment:
		Gtk.Alignment alignment = new Gtk.Alignment (0.50f, 0.25f, 1.0f, 0.5f);
		alignment.right_padding = 20;
		alignment.left_padding = 10;
		this.add (alignment);

		// Alignment content:
		Gtk.Button button = new Gtk.Button.with_label ("Frame content");
		alignment.add (button);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
