public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.SizeGroup";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// A VBox:
		Gtk.Box vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		this.add (vbox);

		// The Sizegroup:
		Gtk.SizeGroup sizegroup = new Gtk.SizeGroup (Gtk.SizeGroupMode.BOTH);

		Gtk.Button button = new Gtk.Button.with_label ("Button 1");
		vbox.pack_start (button, false, false, 0);
		sizegroup.add_widget (button);

		button = new Gtk.Button.with_label ("Button 2");
		vbox.pack_start (button, false, false, 0);
		sizegroup.add_widget (button);

		button = new Gtk.Button.with_label ("Button 3");
		vbox.pack_start (button, false, false, 0);
		sizegroup.add_widget (button);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
