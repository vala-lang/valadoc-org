public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Toolbar";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, -1);


		// The Toolbar:
		Gtk.Toolbar bar = new Gtk.Toolbar ();
		this.add (bar);


		// Toolbar content:
		Gtk.ToolButton button1 = new Gtk.ToolButton.from_stock (Gtk.Stock.OPEN);
		button1.clicked.connect (() => {
			stdout.printf ("Button 1\n");
		});
		bar.add (button1);

		Gtk.ToolButton button2 = new Gtk.ToolButton.from_stock (Gtk.Stock.CLOSE);
		button2.clicked.connect (() => {
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
