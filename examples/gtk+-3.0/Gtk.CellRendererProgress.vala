public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.CellRendererProgress";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Model:
		Gtk.ListStore list_store = new Gtk.ListStore (3, typeof (string), typeof (string), typeof (int));
		Gtk.TreeIter iter;

		list_store.append (out iter);
		list_store.set (iter, 0, "Gtk", 1, "title-gtk", 2, 100);
		list_store.append (out iter);
		list_store.set (iter, 0, "GLib", 1, "title-glib", 2, 50);
		list_store.append (out iter);
		list_store.set (iter, 0, "Gio", 1, "title-gio", 2, 10);

		// The View:
		Gtk.CellRenderer cell = new Gtk.CellRendererText ();
		Gtk.TreeView view = new Gtk.TreeView.with_model (list_store);
		this.add (view);

		view.insert_column_with_attributes (-1, "Package", cell, "text", 0);

		Gtk.CellRendererProgress progress = new Gtk.CellRendererProgress ();
		Gtk.TreeViewColumn column = new Gtk.TreeViewColumn ();
		column.set_title ("Progress");
		column.pack_start (progress, false);
		column.add_attribute (progress, "text", 1);
		column.add_attribute (progress, "value", 2);
		view.append_column (column);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
