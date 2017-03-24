public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ColorChooserDialog";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.ColorChooserDialog dialog = new Gtk.ColorChooserDialog ("Select Your Favorite Color", this);
		if (dialog.run () == Gtk.ResponseType.OK) {
			string alpha = dialog.use_alpha.to_string ();
			string col = dialog.rgba.to_string ();
			print ("Color: %s, Alpha: %s\n", col, alpha);
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
