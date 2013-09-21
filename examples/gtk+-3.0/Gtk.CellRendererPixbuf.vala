public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.CellRendererPixbuf";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Model:
		Gtk.ListStore list_store = new Gtk.ListStore (2, typeof (string), typeof (string));
		Gtk.TreeIter iter;

		list_store.append (out iter);
		list_store.set (iter, 0, "Burgenland", 1, "window-close");
		list_store.append (out iter);
		list_store.set (iter, 0, "Carinthia", 1, "window-close");
		list_store.append (out iter);
		list_store.set (iter, 0, "Lower Austria", 1, "window-close");
		list_store.append (out iter);
		list_store.set (iter, 0, "Upper Austria", 1, "window-close");
		list_store.append (out iter);
		list_store.set (iter, 0, "Salzburg", 1, "window-close");
		list_store.append (out iter);
		list_store.set (iter, 0, "Styria", 1, "window-close");
		list_store.append (out iter);
		list_store.set (iter, 0, "Tyrol", 1, "go-home");
		list_store.append (out iter);
		list_store.set (iter, 0, "Vorarlberg", 1, "window-close");
		list_store.append (out iter);
		list_store.set (iter, 0, "Vienna", 1, "window-close");

		// The View:
		Gtk.TreeView view = new Gtk.TreeView.with_model (list_store);
		this.add (view);

		Gtk.CellRenderer cell = new Gtk.CellRendererText ();
		view.insert_column_with_attributes (-1, "State", cell, "text", 0);

		Gtk.CellRendererPixbuf pixbuf = new Gtk.CellRendererPixbuf ();
		Gtk.TreeViewColumn column = new Gtk.TreeViewColumn ();
		column.set_title ("My Pixbuf");
		column.pack_start (pixbuf, false);
		column.add_attribute (pixbuf, "icon-name", 1);
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
