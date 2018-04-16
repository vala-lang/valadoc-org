public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.FontChooserDialog";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.FontChooserDialog dialog = new Gtk.FontChooserDialog ("Pick your favourite font", this);
		if (dialog.run () == Gtk.ResponseType.OK) {
			print (" font: %s\n", dialog.get_font ().to_string ());
			print (" desc: %s\n", dialog.get_font_desc ().to_string ());
			print (" face: %s\n", dialog.get_font_face ().get_face_name ());
			print (" size: %d\n", dialog.get_font_size ());
			print (" family: %s\n", dialog.get_font_family ().get_name ());
			print (" monospace: %s\n", dialog.get_font_family ().is_monospace ().to_string ());
		}

		// Close the FontChooserDialog
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
