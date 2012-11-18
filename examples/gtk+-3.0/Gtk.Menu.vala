public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Menu";
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

		Gtk.MenuItem item_open = new Gtk.MenuItem.with_label ("Open");
		filemenu.add (item_open);

		// Submenu:
		Gtk.Menu submenu = new Gtk.Menu ();
		item_open.set_submenu (submenu);

		Gtk.MenuItem item_foo = new Gtk.MenuItem.with_label ("foo");
		submenu.add (item_foo);

		Gtk.MenuItem item_bar = new Gtk.MenuItem.with_label ("bar");
		submenu.add (item_bar);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
