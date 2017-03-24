public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.RecentChooserWidget";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The RecentChooserWidget:
		Gtk.RecentChooserWidget chooser = new Gtk.RecentChooserWidget ();
		this.add (chooser);

		chooser.selection_changed.connect (() => {
			string uri = chooser.get_current_uri ();
			print ("%s\n", uri);
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
