public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ImageMenuItem";
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


		Gtk.ImageMenuItem item_open = new Gtk.ImageMenuItem.with_label ("Open");
		Gtk.Image image = new Gtk.Image.from_icon_name ("document-open", Gtk.IconSize.MENU);
		item_open.always_show_image = true;
		item_open.set_image (image);

		item_open.activate.connect (() => {
			Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog (
					"Select your favorite file", this, Gtk.FileChooserAction.OPEN,
					"_Cancel",
					Gtk.ResponseType.CANCEL,
					"_Open",
					Gtk.ResponseType.ACCEPT);

			chooser.run ();
			chooser.close ();
		});
		filemenu.add (item_open);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
