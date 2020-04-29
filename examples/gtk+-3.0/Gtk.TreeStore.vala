public class Application : Gtk.Window {
	public Application () {
		this.title = "My Gtk.TreeStore";
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (250, 100);

		Gtk.TreeView view = new Gtk.TreeView ();
		setup_treeview (view);
		view.expand_all ();
		this.add (view);
	}

	private void setup_treeview (Gtk.TreeView view) {
		Gtk.TreeStore store = new Gtk.TreeStore (2, typeof (string), typeof (string));
		view.set_model (store);

		view.insert_column_with_attributes (-1, "Product", new Gtk.CellRendererText (), "text", 0, null);
		view.insert_column_with_attributes (-1, "Price", new Gtk.CellRendererText (), "text", 1, null);

		Gtk.TreeIter root;
		Gtk.TreeIter category_iter;
		Gtk.TreeIter product_iter;

		store.append (out root, null);
		store.set (root, 0, "All Products", -1);

		store.append (out category_iter, root);
		store.set (category_iter, 0, "Books", -1);

		store.append (out product_iter, category_iter);
		store.set (product_iter, 0, "Moby Dick", 1, "$10.36", -1);
		store.append (out product_iter, category_iter);
		store.set (product_iter, 0, "Heart of Darkness", 1, "$4.99", -1);
		store.append (out product_iter, category_iter);
		store.set (product_iter, 0, "Ulysses", 1, "$26.09", -1);
		store.append (out product_iter, category_iter);
		store.set (product_iter, 0, "Effective Vala", 1, "$38.99", -1);

		store.append (out category_iter, root);
		store.set (category_iter, 0, "Films", -1);

		store.append (out product_iter, category_iter);
		store.set (product_iter, 0, "Amores Perrors", 1, "$7.99", -1);
		store.append (out product_iter, category_iter);
		store.set (product_iter, 0, "Twin Peaks", 1, "$14.99", -1);
		store.append (out product_iter, category_iter);
		store.set (product_iter, 0, "Vertigo", 1, "$20.49", -1);
	}

	public static int main (string[] args) {	 
		Gtk.init (ref args);

		Application sample = new Application ();
		sample.show_all ();
		Gtk.main ();
		return 0;
	}
}
