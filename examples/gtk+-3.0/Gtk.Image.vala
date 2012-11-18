public class Application : Gtk.Window {
	public Application (string img_path) {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Image";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The image:
		Gtk.Image image = new Gtk.Image ();
		image.set_from_file (img_path);
		this.add (image);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		string img_path = "";
		if (args[1] != null) {
			img_path = args[1];
		}

		Application app = new Application (img_path);
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
