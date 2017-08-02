public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ComboBoxText";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The Box:
		Gtk.ComboBoxText box = new Gtk.ComboBoxText ();
		box.append_text ("nemequ");
		box.append_text ("juergbi");
		box.append_text ("flo");
		box.active = 0;
		this.add (box);

		box.changed.connect (() => {
			string title = box.get_active_text ();
			print ("%d: %s\n", box.active, title);
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
