public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.FileChooserDialog";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (500, 500);

		// The FileChooserDialog:
		Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog (
				"Select your favorite file", this, Gtk.FileChooserAction.OPEN,
				Gtk.Stock.CANCEL,
				Gtk.ResponseType.CANCEL,
				Gtk.Stock.OPEN,
				Gtk.ResponseType.ACCEPT);

		// Multiple files can be selected:
		chooser.select_multiple = true;

		// We are only interested in jpegs:
		Gtk.FileFilter filter = new Gtk.FileFilter ();
		chooser.set_filter (filter);
		filter.add_mime_type ("image/jpeg");

		// Add a preview widget:
		Gtk.Image preview_area = new Gtk.Image ();
		chooser.set_preview_widget (preview_area);
		chooser.update_preview.connect (() => {
			string uri = chooser.get_preview_uri ();
			// We only display local files:
			if (uri.has_prefix ("file://") == true) {
				try {
					Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file (uri.substring (7));
					Gdk.Pixbuf scaled = pixbuf.scale_simple (150, 150, Gdk.InterpType.BILINEAR);
					preview_area.set_from_pixbuf (scaled);
					preview_area.show ();
				} catch (Error e) {
					preview_area.hide ();
				}
			} else {
					preview_area.hide ();
			}
		});

		// Process response:
		if (chooser.run () == Gtk.ResponseType.ACCEPT) {
			SList<string> uris = chooser.get_uris ();
			stdout.printf ("Selection:\n");
			foreach (unowned string uri in uris) {
				stdout.printf (" %s\n", uri);
			}
		}

		// Close the FileChooserDialog:
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
