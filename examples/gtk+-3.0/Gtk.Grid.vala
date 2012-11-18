public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Grid";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The Grid:
		Gtk.Grid grid = new Gtk.Grid();
		this.add (grid);

		// XX __ __
		// __ __ __
		// __ __ __
		Gtk.Button button1 = new Gtk.Button.with_label ("1");
		grid.attach(button1, 0, 0, 1, 1);

		// XX __ __
		// XX __ __
		// XX __ __
		Gtk.Button button2 = new Gtk.Button.with_label ("2");
		grid.attach(button2, 0, 1, 1, 2);

		// XX __ __
		// XX XX __
		// XX __ __
		Gtk.Button button3 = new Gtk.Button.with_label ("3");
		grid.attach(button3, 1, 1, 1, 1);

		// XX __ __
		// XX XX __
		// XX __ XX
		Gtk.Button button4 = new Gtk.Button.with_label ("4");
		grid.attach(button4, 2, 2, 1, 1);

		// XX XXXXX
		// XX XX __
		// XX __ XX
		Gtk.Button button5 = new Gtk.Button.with_label ("5");
		grid.attach_next_to (button5, button1, Gtk.PositionType.RIGHT, 2, 1);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
