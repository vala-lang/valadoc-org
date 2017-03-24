public class Application : Gtk.Window {
	public Application () {
		// Sets the title of the Window:
		this.title = "My Gtk.Window";

		// Center window at startup:
		this.window_position = Gtk.WindowPosition.CENTER;

		// Sets the default size of a window:
		this.set_default_size (350, 70);

		// Whether the titlebar should be hidden during maximization.
		this.hide_titlebar_when_maximized = false;

		// Method called on pressing [X]
		this.destroy.connect (() => {
			// Print "Bye!" to our console: 
			print ("Bye!\n");

			// Terminate the mainloop: (main returns 0)
			Gtk.main_quit ();
		});

		// Widget content:
		this.add (new Gtk.Label ("Hello, world!"));
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
