public static int main (string[] args) {
	// Create a ListStore:
	Gtk.ListStore list_store = new Gtk.ListStore (2, typeof (string), typeof (int));
	Gtk.TreeIter iter;

	// Insert data: (0: State, 1: Cities)
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

	// Output:
	//  ``Entry: Burgenland		13``
	//  ``Entry: Carinthia		17``
	//  ``Entry: Lower Austria	75``
	//  ``Entry: Upper Austria	32``
	//  ``Entry: Salzburg		10``
	//  ``Entry: Styria			34``
	//  ``Entry: Tyrol			11``
	//  ``Entry: Vorarlberg		5``
	//  ``Entry: Vienna			1``
	for (bool next = list_store.get_iter_first (out iter); next; next = list_store.iter_next (ref iter)) {
		Value val1, val2;
		list_store.get_value (iter, 0, out val1);
		list_store.get_value (iter, 1, out val2);
		print ("Entry: %s\t%d\n", (string) val1, (int) val2);
	}
	return 0;
}
