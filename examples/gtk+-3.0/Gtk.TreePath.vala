public static int main (string[] args) {
	// Create a TreeStore [string, string]:
	Gtk.TreeStore store = new Gtk.TreeStore (2, typeof (string), typeof (string));

	// Add data:
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
	store.set (product_iter, 0, "Amores Perros", 1, "$7.99", -1);
	store.append (out product_iter, category_iter);
	store.set (product_iter, 0, "Twin Peaks", 1, "$14.99", -1);
	store.append (out product_iter, category_iter);
	store.set (product_iter, 0, "Vertigo", 1, "$20.49", -1);

	// Query:
	// + All Products
	//   + Books
	//     + Moby Dick				$10.36
	//     + Heart of Darkness		$4.99
	//     + Ulysses				$26.09
	//     + Effective Vala			$38.99
	//   + Films
	//     + Amores Perros			$7.99
	//     + Twin Peaks				$14.99
	// 	   + Vertigo				$20.49

	// Output: ``0:0:0: Moby Dick``
	Gtk.TreePath path = new Gtk.TreePath ();
	path.append_index (0);
	path.append_index (0);
	path.append_index (0);

	Gtk.TreeIter iter;
	Value val;

	store.get_iter (out iter, path);
	store.get_value (iter, 0, out val); 
	print ("%s: %s\n", path.to_string (), (string) val);

	// Output: ``0:0:1: Heart of Darkness``
	path = new Gtk.TreePath.from_indices (0, 0, 1);
	store.get_iter (out iter, path);
	store.get_value (iter, 0, out val); 
	print ("%s: %s\n", path.to_string (), (string) val);

	// Output: ``0:1:2: Vertigo``
	path = new Gtk.TreePath.from_string ("0:1:2");
	store.get_iter (out iter, path);
	store.get_value (iter, 0, out val); 
	print ("%s: %s\n", path.to_string (), (string) val);

	return 0;
}
