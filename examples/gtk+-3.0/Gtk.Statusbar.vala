public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Statusbar";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// A Box:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		this.add (box);

		// The Statusbar:
		Gtk.Statusbar bar = new Gtk.Statusbar ();
		box.pack_start (bar, false, false, 0);

		uint context_id = bar.get_context_id ("example");
		bar.push (context_id, "Waiting for response ...");

		// A Button:
		Gtk.Button button = new Gtk.Button.with_label ("Update");
		box.pack_start (button, false, false, 0);

		button.clicked.connect (() => {
			bar.push (context_id, "Waiting for more response ...");
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
