public class Application : Gtk.Window {
	private void toggled (Gtk.ToggleButton button) {
		print ("%s\n", button.label);
	}

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.RadioButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// A VBox:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		this.add (box);

		// The buttons:
		Gtk.RadioButton button1 = new Gtk.RadioButton.with_label_from_widget (null, "Button 1");
		box.pack_start (button1, false, false, 0);
		button1.toggled.connect (toggled);

		Gtk.RadioButton button = new Gtk.RadioButton.with_label_from_widget (button1, "Button 2");
		box.pack_start (button, false, false, 0);
		button.toggled.connect (toggled);

		button = new Gtk.RadioButton.with_label_from_widget (button1, "Button 3");
		box.pack_start (button, false, false, 0);
		button.toggled.connect (toggled);
		button.set_active (true);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
