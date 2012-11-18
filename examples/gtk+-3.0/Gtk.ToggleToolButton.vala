public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ToggleToolButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, -1);


		// The Toolbar:
		Gtk.Toolbar bar = new Gtk.Toolbar ();
		this.add (bar);


		// Toolbar content:
		Gtk.ToggleToolButton button1 = new Gtk.ToggleToolButton.from_stock (Gtk.Stock.OPEN);
		button1.toggled.connect (() => {
			stdout.printf ("Button 1\n");
		});
		bar.add (button1);

		Gtk.ToggleToolButton button2 = new Gtk.ToggleToolButton.from_stock (Gtk.Stock.CLOSE);
		button2.set_active (true);
		button2.toggled.connect (() => {
			stdout.printf ("Button 2\n");
		});
		bar.add (button2);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
