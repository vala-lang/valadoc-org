public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.CellRendererCombo";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// Combo, Model:
		Gtk.ListStore combo_model = new Gtk.ListStore (1, typeof (string));
		Gtk.TreeIter iter;

		combo_model.append (out iter);
		combo_model.set (iter, 0, "LGPL");
		combo_model.append (out iter);
		combo_model.set (iter, 0, "GPL");
		combo_model.append (out iter);
		combo_model.set (iter, 0, "MIT");
		combo_model.append (out iter);
		combo_model.set (iter, 0, "BSD");

		// Tree, Model:
		Gtk.ListStore list_model = new Gtk.ListStore (2, typeof (string), typeof (string));

		list_model.append (out iter);
		list_model.set (iter, 0, "Gtk", 1, "LGPL");
		list_model.append (out iter);
		list_model.set (iter, 0, "GLib", 1, "LGPL");
		list_model.append (out iter);
		list_model.set (iter, 0, "Epiphany", 1, "GPL");

		// The View:
		Gtk.TreeView view = new Gtk.TreeView.with_model (list_model);
		this.add (view);

		Gtk.CellRenderer cell = new Gtk.CellRendererText ();
		view.insert_column_with_attributes (-1, "Package", cell, "text", 0);


		Gtk.TreeViewColumn column = new Gtk.TreeViewColumn ();
		column.set_title ("Licence");
		view.append_column (column);

		Gtk.CellRendererCombo combo = new Gtk.CellRendererCombo ();
		combo.set_property ("editable", true);
		combo.set_property ("model", combo_model);
		combo.set_property ("text-column", 0);
		column.pack_start (combo, false);
		column.add_attribute (combo, "text", 1);

		combo.changed.connect((path, iter_new) => {
			Gtk.TreeIter iter_val;
			Value val;

			combo_model.get_value (iter_new, 0, out val);
			list_model.get_iter (out iter_val, new Gtk.TreePath.from_string (path));
			list_model.set_value (iter_val, 1, val);
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
