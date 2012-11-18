public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Frame";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The frame:
		Gtk.Frame frame = new Gtk.Frame ("<b>My title:</b>");
		(frame.label_widget as Gtk.Label).use_markup = true;
		this.add (frame);

		// Frame content:
		Gtk.Alignment alignment = new Gtk.Alignment (0.50f, 0.50f, 1.0f, 1.0f);
		alignment.left_padding = 12;
		frame.add (alignment);

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
