public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.CheckMenuItem";
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

		Gtk.CheckMenuItem item_option = new Gtk.CheckMenuItem.with_label ("My Option");
		item_option.set_active (true);
		filemenu.add (item_option);

		item_option.toggled.connect (() => {
			print ("%s\n", item_option.active.to_string ());
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
