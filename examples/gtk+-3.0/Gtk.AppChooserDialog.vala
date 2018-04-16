public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.AppChooserDialog";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.AppChooserDialog dialog = new Gtk.AppChooserDialog.for_content_type (this, 0, "image/png");
		if (dialog.run () == Gtk.ResponseType.OK) {
			AppInfo info = dialog.get_app_info ();
			if (info != null) {
				print ("%s:\n", title);
				print (" Name: %s\n", info.get_display_name ());
				print (" Desc: %s\n", info.get_description ());
			}
		}
		dialog.close ();
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
