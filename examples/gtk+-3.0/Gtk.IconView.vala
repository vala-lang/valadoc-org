public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.IconView";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (400, 400);

		// The Model:
		Gtk.ListStore model = new Gtk.ListStore (2, typeof (Gdk.Pixbuf), typeof (string));
		Gtk.TreeIter iter;

		// The IconView:
		Gtk.IconView view = new Gtk.IconView.with_model (model);
		view.set_pixbuf_column (0);
		view.set_text_column (1);
		this.add (view);

		// Data:
		Gtk.IconTheme icon_theme = Gtk.IconTheme.get_default ();

		try {
			model.append (out iter);
			Gdk.Pixbuf pixbuf = icon_theme.load_icon ("help-about", 20, 0);
			model.set (iter, 0, pixbuf, 1, "Dialog");

			model.append (out iter);
			pixbuf = icon_theme.load_icon ("document-print", 20, 0);
			model.set (iter, 0, pixbuf, 1, "Print");

			model.append (out iter);
			pixbuf = icon_theme.load_icon ("help-about", 20, 0);
			model.set (iter, 0, pixbuf, 1, "Help");
		} catch (Error e) {
			// TODO
			assert_not_reached ();
		}


		view.selection_changed.connect (() => {
			List<Gtk.TreePath> paths = view.get_selected_items ();
			Value title;
			Value icon;

			foreach (Gtk.TreePath path in paths) {
				bool tmp = model.get_iter (out iter, path);
				assert (tmp == true);

				model.get_value (iter, 0, out icon); 
				model.get_value (iter, 1, out title); 
				print ("%s: %p\n", (string) title, ((Gdk.Pixbuf) icon));
			}
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
