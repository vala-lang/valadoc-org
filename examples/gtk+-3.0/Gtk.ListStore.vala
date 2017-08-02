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


	// List data:
	Gtk.TreeModelForeachFunc print_row = (model, path, iter) => {
		GLib.Value cell1;
		GLib.Value cell2;

		list_store.get_value (iter, 0, out cell1);
		list_store.get_value (iter, 1, out cell2);

		print ("%s\t%d\n", (string) cell1, (int) cell2);
		return false;
	};

	// Output:
	//  ``Burgenland	13``
	//  ``Carinthia		17``
	//  ``Lower Austria	75``
	//  ``Upper Austria	32``
	//  ``Salzburg		10``
	//  ``Styria		34``
	//  ``Tyrol			11``
	//  ``Vorarlberg	5``
	//  ``Vienna		1``
	list_store.foreach (print_row);



	// Modify a particular row
	Gtk.TreePath path = new Gtk.TreePath.from_string ("2");
	bool tmp = list_store.get_iter (out iter, path);
	assert (tmp == true);
	list_store.set (iter, 1, -10);

	// Output:
	//  ``Burgenland	13``
	//  ``Carinthia		17``
	//  ``Lower Austria	-10``
	//  ``Upper Austria	32``
	//  ``Salzburg		10``
	//  ``Styria		34``
	//  ``Tyrol			11``
	//  ``Vorarlberg	5``
	//  ``Vienna		1``
	print ("----\n");
	list_store.foreach (print_row);

	return 0;
}
