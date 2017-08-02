public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ComboBox";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// Create & fill a ListStore:
		Gtk.ListStore list_store = new Gtk.ListStore (2, typeof (string), typeof (int));
		Gtk.TreeIter iter;

		list_store.append (out iter);
		list_store.set (iter, 0, "Burgenland", 1, 13);
		list_store.append (out iter);
		list_store.set (iter, 0, "Carinthia", 1, 17);

		// The Box:
		Gtk.ComboBox box = new Gtk.ComboBox.with_model (list_store);
		this.add (box);

		Gtk.CellRendererText renderer = new Gtk.CellRendererText ();
		box.pack_start (renderer, true);
		box.add_attribute (renderer, "text", 0);
		box.active = 0;

		renderer = new Gtk.CellRendererText ();
		box.pack_start (renderer, true);
		box.add_attribute (renderer, "text", 1);
		box.active = 0;

		box.changed.connect (() => {
			Value val1;
			Value val2;

			box.get_active_iter (out iter);
			list_store.get_value (iter, 0, out val1);
			list_store.get_value (iter, 1, out val2);

			print ("Selection: %s, %d\n", (string) val1, (int) val2);
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
