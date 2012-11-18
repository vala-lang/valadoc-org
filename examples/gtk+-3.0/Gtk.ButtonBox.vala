public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ButtonBox";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// Create buttons:
		Gtk.Button[] buttons = {
			new Gtk.Button.with_label ("L1"),
			new Gtk.Button.with_label ("L2"),
			new Gtk.Button.with_label ("L3")
		};

		// The ButtonBox:
		Gtk.ButtonBox box = new Gtk.ButtonBox (Gtk.Orientation.VERTICAL);
		box.set_layout (Gtk.ButtonBoxStyle.START);

		// The number of pixels to place between children:
		box.set_spacing (5);

		// Add buttons to our ButtonBox:
		foreach (unowned Gtk.Button button in buttons) {
			box.add (button);
		}

		// L2 should appear in a secondary group of children:
		box.set_child_secondary (buttons[1], true);

		this.add (box);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
