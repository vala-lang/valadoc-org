public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.RadioMenuItem";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// MenuBar:
		Gtk.MenuBar bar = new Gtk.MenuBar ();
		this.add (bar);

		// File:
		Gtk.MenuItem item_file = new Gtk.MenuItem.with_label ("File");
		bar.add (item_file);

		Gtk.Menu filemenu = new Gtk.Menu ();
		item_file.set_submenu (filemenu);

		Gtk.RadioMenuItem item_first = new Gtk.RadioMenuItem.with_label (null, "First");
		unowned SList<Gtk.RadioMenuItem> group = item_first.get_group ();
		item_first.set_active (true);
		filemenu.add (item_first);

		Gtk.RadioMenuItem item_second = new Gtk.RadioMenuItem.with_label (group, "Second");
		filemenu.add (item_second);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
