public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.RadioToolButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, -1);

		// The Toolbar:
		Gtk.Toolbar bar = new Gtk.Toolbar ();
		this.add (bar);


		// Toolbar content:
		Gtk.RadioToolButton button1 = new Gtk.RadioToolButton.from_stock (null, Gtk.Stock.OPEN);
		bar.add (button1);

		Gtk.RadioToolButton button2 = new Gtk.RadioToolButton.from_stock (button1.get_group (), Gtk.Stock.CLOSE);
		bar.add (button2);

		button1.clicked.connect (() => {
			stdout.puts ("Button 1, clicked\n");
		});

		button2.clicked.connect (() => {
			stdout.puts ("Button 2, clicked\n");
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
