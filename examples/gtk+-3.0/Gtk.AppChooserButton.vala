public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.AppChooserButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.AppChooserButton button = new Gtk.AppChooserButton ("image/png");
		this.add (button);

		// Add a separator line:
		button.append_separator ();

		// Add a custom entry:
		ThemedIcon themed_icon = new ThemedIcon ("folder-new");
		button.append_custom_item ("my-image-viewer", "My image Viewer", themed_icon);

		// Catch custom selections:
		button.custom_item_activated.connect ((item_name) => {
			print ("%s\n", item_name);
		});

		// Catch all selections:
		button.changed.connect (() => {
			AppInfo info = button.get_app_info ();
			if (info != null) {
				print ("Selection:\n");
				print (" Name: %s\n", info.get_display_name ());
				print (" Desc: %s\n", info.get_description ());
			}
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
