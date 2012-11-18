public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.CellRendererSpinner";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The Model:
		Gtk.ListStore list_store = new Gtk.ListStore (3, typeof (string), typeof (bool), typeof (int));
		Gtk.TreeIter iter;

		list_store.append (out iter);
		list_store.set (iter, 0, "Burgenland", 1, true, 2, 1);
		list_store.append (out iter);
		list_store.set (iter, 0, "Carinthia", 1, false, 2, 0);
		list_store.append (out iter);
		list_store.set (iter, 0, "Lower Austria", 1, true, 2, 3);

		// The View:
		Gtk.TreeView view = new Gtk.TreeView.with_model (list_store);
		this.add (view);

		Gtk.CellRenderer cell = new Gtk.CellRendererText ();
		view.insert_column_with_attributes (-1, "State", cell, "text", 0);

		Gtk.CellRendererSpinner spinner = new Gtk.CellRendererSpinner ();

		Gtk.TreeViewColumn column = new Gtk.TreeViewColumn ();
		column.set_title ("Cities");
		column.pack_start (spinner, false);
		column.add_attribute (spinner, "active", 1);
		column.add_attribute (spinner, "pulse", 2);
		view.append_column (column);

		// Update the spinner pos:
		Timeout.add (50, () => {
			list_store.foreach ((model, path, iter) => {
				Value val;
				list_store.get_value (iter, 2, out val);
				val.set_int (val.get_int () + 1);
				list_store.set_value (iter, 2, val);
				return false;
			});
			return true;
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
