public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.FileChooserWidget";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// VBox:
		Gtk.Box vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 5);
		this.add (vbox);

		// Add a chooser:
		Gtk.FileChooserWidget chooser = new Gtk.FileChooserWidget (Gtk.FileChooserAction.OPEN);
		vbox.pack_start (chooser, true, true, 0);

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

		// Emitted when there is a change in the set of selected files:
		chooser.selection_changed.connect (() => {
			SList<string> uris = chooser.get_uris ();
			foreach (unowned string uri in uris) {
				print ("Selection changed:\n");
				print (" %s\n", uri);
			}
		});

		// HBox:
		Gtk.Box hbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 5);
		vbox.pack_start(hbox, false, false, 0);

	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
