public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.FontSelection";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// A VBox:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		this.add (box);

		// The FontSelection:
		Gtk.FontSelection selection = new Gtk.FontSelection ();
		box.add (selection);

		// A Button:
		Gtk.Button button = new Gtk.Button.with_label ("Select");
		box.add (button);

		button.clicked.connect (() => {
			// Emitted when a font has been chosen:
			string name = selection.get_font_name ();
			print ("Selected font: %s\n", name);
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
