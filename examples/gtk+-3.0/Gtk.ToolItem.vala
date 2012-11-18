public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ToolItem";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, -1);


		// The Toolbar:
		Gtk.Toolbar bar = new Gtk.Toolbar ();
		this.add (bar);

		// ToolItem:
		Gtk.ToolItem button = new Gtk.ToolItem ();
		bar.add (button);

		// ToolItem content:
		Gtk.Spinner spinner = new Gtk.Spinner ();
		button.add (spinner);
		spinner.start ();
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
