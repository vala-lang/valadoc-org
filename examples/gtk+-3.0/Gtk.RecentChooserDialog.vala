public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.RecentChooserDialog";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (500, 500);

		// The RecentChooserDialog:
		Gtk.RecentChooserDialog chooser = new Gtk.RecentChooserDialog (
				"Select your favorite file", this,
				"_Cancel",
				Gtk.ResponseType.CANCEL,
				"_Open",
				Gtk.ResponseType.OK);

		// Process response:
		if (chooser.run () == Gtk.ResponseType.OK) {
			string uri = chooser.get_current_uri ();
			print ("%s\n", uri);
		}

		// Close the RecentChooserDialog:
		chooser.close ();
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
