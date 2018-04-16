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
				"_Cancel",
				Gtk.ResponseType.CANCEL,
				"_Open",
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
			if (uri != null && uri.has_prefix ("file://") == true) {
				try {
					Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file_at_scale (uri.substring (7), 150, 	150, true);
					preview_area.set_from_pixbuf (pixbuf);
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
			print ("Selection:\n");
			foreach (unowned string uri in uris) {
				print (" %s\n", uri);
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
