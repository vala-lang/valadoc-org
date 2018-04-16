public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ColorChooserWidget";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The Box:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		this.add (box);

		// The ColorChooserWidget:
		Gtk.ColorChooserWidget widget = new Gtk.ColorChooserWidget ();
		box.add (widget);

		// A ToggleButton:
		Gtk.Button toggle = new Gtk.Button.with_label ("Toggle Single/Multi Color Mode");
		box.add (toggle);

		toggle.clicked.connect (() => {
			widget.show_editor = !widget.show_editor;
		});

		// A Button:
		Gtk.Button button = new Gtk.Button.with_label ("Print Color");
		box.add (button);

		button.clicked.connect (() => {
			string alpha = widget.use_alpha.to_string ();
			string col = widget.rgba.to_string ();
			print ("Color: %s, Alpha: %s\n", col, alpha);
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
