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
		Gtk.Image img = new Gtk.Image.from_icon_name ("document-open", Gtk.IconSize.SMALL_TOOLBAR);
		Gtk.ToggleToolButton button1 = new Gtk.ToggleToolButton ();
		button1.set_icon_widget (img);
		button1.toggled.connect (() => {
			print ("Button 1, %s\n", button1.get_active ().to_string ());
		});
		bar.add (button1);

		img = new Gtk.Image.from_icon_name ("window-close", Gtk.IconSize.SMALL_TOOLBAR);
		Gtk.ToggleToolButton button2 = new Gtk.ToggleToolButton ();
		button2.set_icon_widget (img);
		button2.set_active (true);
		button2.toggled.connect (() => {
			print ("Button 2, %s\n", button2.get_active ().to_string ());
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
