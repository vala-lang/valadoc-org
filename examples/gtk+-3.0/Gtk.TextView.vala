public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.TextView";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (400, 400);

		// Box:
		Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 1);
		this.add (box);

		// A ScrolledWindow:
		Gtk.ScrolledWindow scrolled = new Gtk.ScrolledWindow (null, null);
		box.pack_start (scrolled, true, true, 0);

		// The TextView:
		Gtk.TextView view = new Gtk.TextView ();
		view.set_wrap_mode (Gtk.WrapMode.WORD);
		view.buffer.text = "Lorem Ipsum";
		scrolled.add (view);

		// A Button:
		Gtk.Button button = new Gtk.Button.with_label ("Print content to stdout");
		box.pack_start (button, false, true, 0);
		button.clicked.connect (() => {
			print (view.buffer.text);
			print ("\n");
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
