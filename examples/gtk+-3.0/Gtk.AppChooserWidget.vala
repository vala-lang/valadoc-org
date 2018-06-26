public class Application : Gtk.Window {
	private void print_selection (string title, Gtk.AppChooserWidget widget) {
		AppInfo info = widget.get_app_info ();
		if (info != null) {
			print ("%s:\n", title);
			print (" Name: %s\n", info.get_display_name ());
			print (" Desc: %s\n", info.get_description ());
		}
	}

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.AppChooserWidget";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.AppChooserWidget widget = new Gtk.AppChooserWidget ("image/png");
		this.add (widget);

		// Catch all selections:
		widget.application_activated.connect (() => {
			print_selection ("Activated", widget);
		});

		widget.application_selected.connect (() => {
			print_selection ("Selected", widget);
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
