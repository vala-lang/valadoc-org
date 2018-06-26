public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.SeparatorToolItem";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, -1);


		// The Toolbar:
		Gtk.Toolbar bar = new Gtk.Toolbar ();
		this.add (bar);


		// Toolbar content:
		Gtk.Image img = new Gtk.Image.from_icon_name ("document-open", Gtk.IconSize.SMALL_TOOLBAR);
		Gtk.ToolButton button1 = new Gtk.ToolButton (img, null);
		button1.clicked.connect (() => {
			print ("Button 1\n");
		});
		bar.add (button1);

		Gtk.SeparatorToolItem separator = new Gtk.SeparatorToolItem ();
		bar.add (separator);

		img = new Gtk.Image.from_icon_name ("window-close", Gtk.IconSize.SMALL_TOOLBAR);
		Gtk.ToolButton button2 = new Gtk.ToolButton (img, null);
		button2.clicked.connect (() => {
			print ("Button 2\n");
		});
		bar.add (button2);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
