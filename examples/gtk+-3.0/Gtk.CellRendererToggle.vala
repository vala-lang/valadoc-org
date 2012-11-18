public class Application : Gtk.Window {
	private Gtk.ListStore list_store;
	private Gtk.TreeView tree_view;

	private enum Columns {
		TOGGLE,
		TEXT,
		N_COLUMNS
	}

	public Application () {
		this.title = "My Gtk.CellRendererToggle";
		this.destroy.connect (Gtk.main_quit);
		set_size_request (200, 200);

		list_store = new Gtk.ListStore (Columns.N_COLUMNS, typeof (bool), typeof (string));
		tree_view = new Gtk.TreeView.with_model (list_store);

		Gtk.CellRendererToggle toggle = new Gtk.CellRendererToggle ();
		toggle.toggled.connect ((toggle, path) => {
			Gtk.TreePath tree_path = new Gtk.TreePath.from_string (path);
			Gtk.TreeIter iter;
			list_store.get_iter (out iter, tree_path);
			list_store.set (iter, Columns.TOGGLE, !toggle.active);
		});

		Gtk.TreeViewColumn column = new Gtk.TreeViewColumn ();
		column.pack_start (toggle, false);
		column.add_attribute (toggle, "active", Columns.TOGGLE);
		tree_view.append_column (column);

		Gtk.CellRendererText text = new Gtk.CellRendererText ();

		column = new Gtk.TreeViewColumn ();
		column.pack_start (text, true);
		column.add_attribute (text, "text", Columns.TEXT);
		tree_view.append_column (column);
 
		tree_view.set_headers_visible (false);
 
		Gtk.TreeIter iter;
		list_store.append (out iter);
		list_store.set (iter, Columns.TOGGLE, true, Columns.TEXT, "item 1");
		list_store.append (out iter);
		list_store.set (iter, Columns.TOGGLE, false, Columns.TEXT, "item 2");
 
		this.add (tree_view);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application sample = new Application ();
		sample.show_all ();
		Gtk.main ();
		return 0;
	}
}
