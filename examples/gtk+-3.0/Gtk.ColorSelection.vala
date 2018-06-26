public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ColorSelection";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The Box:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		this.add (box);

		// The ColorChooserWidget:
		Gtk.ColorSelection widget = new Gtk.ColorSelection ();
		box.add (widget);

		// A Button:
		Gtk.Button button = new Gtk.Button.with_label ("Print Selection");
		box.add (button);

		button.clicked.connect (() => {
			string rgba = widget.current_rgba.to_string ();
			uint alpha = widget.current_alpha;
			print ("Selection\n");
			print ("  %s\n", rgba);
			print ("  %u\n", alpha);
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
