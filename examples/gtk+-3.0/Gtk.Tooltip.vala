public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Tooltip";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// A VBox:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		this.add (box);

		// A simple Tooltip:
		Gtk.Button button = new Gtk.Button.with_label ("Button 1");
		button.set_tooltip_text ("My Tooltip");
		box.add (button);

		// A simple Tooltip with markup:
		button = new Gtk.Button.with_label ("Button 2");
		button.set_tooltip_markup ("<b>My Tooltip</b>");
		box.add (button);

		// A complex Tooltip:
		button = new Gtk.Button.with_label ("Button 3");
		button.has_tooltip = true;
		box.add (button);

		button.query_tooltip.connect ((x, y, keyboard_tooltip, tooltip) => {
			tooltip.set_icon_from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR); 
			tooltip.set_markup ("<b>My Tooltip</b>");
			return true;
		});

		// A custom Tooltip:
		button = new Gtk.Button.with_label ("Button 3");
		button.has_tooltip = true;
		box.add (button);

		button.query_tooltip.connect ((x, y, keyboard_tooltip, tooltip) => {
			tooltip.set_custom (new Gtk.Button.with_label ("You can't click me. :)"));
			return true;
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
