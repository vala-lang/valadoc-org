public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Entry";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Entry:
		Gtk.Entry entry = new Gtk.Entry ();
		this.add (entry);

		// Add a default-text:
		entry.set_text ("hello, world!");

		// Add a delete-button:
		entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear");
		entry.icon_press.connect ((pos, event) => {
			if (pos == Gtk.EntryIconPosition.SECONDARY) {
				entry.set_text ("");
			}
		});

		// Print text to stdout on enter:
		entry.activate.connect (() => {
			unowned string str = entry.get_text ();
			print ("%s\n", str);
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
