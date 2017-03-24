public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Switch";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.Switch _switch = new Gtk.Switch ();
		this.add (_switch);

		_switch.notify["active"].connect (() => {
			if (_switch.active) {
				print ("The switch is on!\n");
			} else {
				print ("The switch is off!\n");
			}
		});

		// Changes the state to on:
		_switch.set_active (true);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
