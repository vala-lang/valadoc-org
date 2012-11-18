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
			stdout.printf ("%s\n", font);
			stdout.printf (" font: %s\n", widget.get_font ().to_string ());
			stdout.printf (" desc: %s\n", widget.get_font_desc ().to_string ());
			stdout.printf (" face: %s\n", widget.get_font_face ().get_face_name ());
			stdout.printf (" size: %d\n", widget.get_font_size ());
			stdout.printf (" family: %s\n", widget.get_font_family ().get_name ());
			stdout.printf (" monospace: %s\n", widget.get_font_family ().is_monospace ().to_string ());
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
