public class Application : Gtk.Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.FontChooserWidget";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The button:
		Gtk.FontChooserWidget widget = new Gtk.FontChooserWidget ();
		this.add (widget);

		widget.font_activated.connect ((font) => {
			print ("%s\n", font);
			print (" font: %s\n", widget.get_font ().to_string ());
			print (" desc: %s\n", widget.get_font_desc ().to_string ());
			print (" face: %s\n", widget.get_font_face ().get_face_name ());
			print (" size: %d\n", widget.get_font_size ());
			print (" family: %s\n", widget.get_font_family ().get_name ());
			print (" monospace: %s\n", widget.get_font_family ().is_monospace ().to_string ());
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
