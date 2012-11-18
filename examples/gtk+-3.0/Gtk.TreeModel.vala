public class MyNode : Object {
	// Data:
	public int id { get; set; }
	public string name { get; set; }
	public int price { get; set; }
	public int stock { get; set; }

	public MyNode (int id, string name, int price, int stock) {
		this.price = price;
		this.stock = stock;
		this.name = name;
		this.id = id;
	}
}

public class MyModel : Object, Gtk.TreeModel {
	private GenericArray<MyNode> data;
	private int stamp = 0;

	public MyModel (owned GenericArray<MyNode>? data = null) {
		if (data == null) {
			this.data = new GenericArray<MyNode> ();
		} else {
			this.data = (owned) data;
		}
	}

	public void add (int id, string name, int price, int stock) {
		data.add (new MyNode (id, name, price, stock));
		stamp++;
	}

	public Type get_column_type (int index) {
		switch (index) {
		case 0:
		case 2:
		case 3:
			return typeof (int);

		case 1:
			return typeof (string);

		default:
			return Type.INVALID;
		}
	}

	public Gtk.TreeModelFlags get_flags () {
		return 0;
	}

	public void get_value (Gtk.TreeIter iter, int column, out Value val) {
		assert (iter.stamp == stamp);

		MyNode node = data.get ((int) iter.user_data);
		switch (column) {
		case 0:
			val = Value (typeof (int));
			val.set_int (node.id);
			break;

		case 1:
			val = Value (typeof (string));
			val.set_string (node.name);
			break;

		case 2:
			val = Value (typeof (int));
			val.set_int (node.price);
			break;

		case 3:
			val = Value (typeof (int));
			val.set_int (node.stock);
			break;

		default:
			val = Value (Type.INVALID);
			break;
		}
	}

	public bool get_iter (out Gtk.TreeIter iter, Gtk.TreePath path) {
		if (path.get_depth () != 1 || data.length == 0) {
			return invalid_iter (out iter);
		}

		iter = Gtk.TreeIter ();
		iter.user_data = path.get_indices ()[0].to_pointer ();
		iter.stamp = this.stamp;
		return true;
	}

	public int get_n_columns () {
		// id, name, price, stock
		return 4;
	}

	public Gtk.TreePath? get_path (Gtk.TreeIter iter) {
		assert (iter.stamp == stamp);

		Gtk.TreePath path = new Gtk.TreePath ();
		path.append_index ((int) iter.user_data);
		return path;
	}

	public int iter_n_children (Gtk.TreeIter? iter) {
		assert (iter == null || iter.stamp == stamp);
		return (iter == null)? data.length : 0;
	}

	public bool iter_next (ref Gtk.TreeIter iter) {
		assert (iter.stamp == stamp);

		int pos = ((int) iter.user_data) + 1;
		if (pos >= data.length) {
			return false;
		}
		iter.user_data = pos.to_pointer ();
		return true;
	}

	public bool iter_previous (ref Gtk.TreeIter iter) {
		assert (iter.stamp == stamp);

		int pos = (int) iter.user_data;
		if (pos >= 0) {
			return false;
		}

		iter.user_data = (--pos).to_pointer ();
		return true;
	}

	public bool iter_nth_child (out Gtk.TreeIter iter, Gtk.TreeIter? parent, int n) {
		assert (parent == null || parent.stamp == stamp);

		if (parent == null && n < data.length) {
			iter = Gtk.TreeIter ();
			iter.stamp = stamp;
			iter.user_data = n.to_pointer ();
			return true;
		}

		// Only used for trees
		return invalid_iter (out iter);
	}

	public bool iter_children (out Gtk.TreeIter iter, Gtk.TreeIter? parent) {
		assert (parent == null || parent.stamp == stamp);
		// Only used for trees
		return invalid_iter (out iter);
	}

	public bool iter_has_child (Gtk.TreeIter iter) {
		assert (iter.stamp == stamp);
		// Only used for trees
		return false;
	}

	public bool iter_parent (out Gtk.TreeIter iter, Gtk.TreeIter child) {
		assert (child.stamp == stamp);
		// Only used for trees
		return invalid_iter (out iter);
	}

	private bool invalid_iter (out Gtk.TreeIter iter) {
		iter = Gtk.TreeIter ();
		iter.stamp = -1;		
		return false;
	}
}

public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.TreeModel";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// Model:
		MyModel model = new MyModel ();
		model.add (1, "hallo" , 10, 100);
		model.add (2, "welt", 20, 50);
		model.add (3, "!!", 20, 50);

		GenericArray<MyNode> data = new GenericArray<MyNode> ();
		data.add (new MyNode (1, "hallo" , 10, 100));
		data.add (new MyNode (2, "welt", 20, 50));
		data.add (new MyNode (3, "!!", 20, 50));

		// View:
		Gtk.TreeView view = new Gtk.TreeView.with_model (model);
		view.insert_column_with_attributes (-1, "ID", new Gtk.CellRendererText (), "text", 0);
		view.insert_column_with_attributes (-1, "Name", new Gtk.CellRendererText (), "text", 1);
		view.insert_column_with_attributes (-1, "Price", new Gtk.CellRendererText (), "text", 2);
		view.insert_column_with_attributes (-1, "Stock", new Gtk.CellRendererSpin (), "text", 3);
		this.add (view);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
