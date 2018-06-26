public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.RecentChooserMenu";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// MenuBar:
		Gtk.MenuBar bar = new Gtk.MenuBar ();
		this.add (bar);

		// File:
		Gtk.MenuItem item_file = new Gtk.MenuItem.with_label ("File");
		bar.add (item_file);

		Gtk.RecentChooserMenu recent = new Gtk.RecentChooserMenu ();
		item_file.set_submenu (recent);

		recent.item_activated.connect (() => {
			Gtk.RecentInfo info = recent.get_current_item ();
			print ("%s\n", info.get_uri ());
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
