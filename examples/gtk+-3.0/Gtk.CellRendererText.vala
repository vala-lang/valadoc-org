public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.CellRendererText";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Model:
		Gtk.ListStore list_store = new Gtk.ListStore (2, typeof (string), typeof (int));
		Gtk.TreeIter iter;

		list_store.append (out iter);
		list_store.set (iter, 0, "Burgenland", 1, 13);
		list_store.append (out iter);
		list_store.set (iter, 0, "Carinthia", 1, 17);
		list_store.append (out iter);
		list_store.set (iter, 0, "Lower Austria", 1, 75);
		list_store.append (out iter);
		list_store.set (iter, 0, "Upper Austria", 1, 32);
		list_store.append (out iter);
		list_store.set (iter, 0, "Salzburg", 1, 10);
		list_store.append (out iter);
		list_store.set (iter, 0, "Styria", 1, 34);
		list_store.append (out iter);
		list_store.set (iter, 0, "Tyrol", 1, 11);
		list_store.append (out iter);
		list_store.set (iter, 0, "Vorarlberg", 1, 5);
		list_store.append (out iter);
		list_store.set (iter, 0, "Vienna", 1, 1);

		// The View:
		Gtk.TreeView view = new Gtk.TreeView.with_model (list_store);
		this.add (view);

		Gtk.CellRendererText cell = new Gtk.CellRendererText ();
		view.insert_column_with_attributes (-1, "State", cell, "text", 0);
		view.insert_column_with_attributes (-1, "Cities", cell, "text", 1);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
