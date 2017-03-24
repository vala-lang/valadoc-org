public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.RadioToolButton";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, -1);

		// The Toolbar:
		Gtk.Toolbar bar = new Gtk.Toolbar ();
		this.add (bar);


		// Toolbar content:
		Gtk.Image img = new Gtk.Image.from_icon_name ("document-open", Gtk.IconSize.SMALL_TOOLBAR);
		Gtk.RadioToolButton button1 = new Gtk.RadioToolButton (null);
		button1.set_icon_widget (img);
		bar.add (button1);

		img = new Gtk.Image.from_icon_name ("window-close", Gtk.IconSize.SMALL_TOOLBAR);
		Gtk.RadioToolButton button2 = new Gtk.RadioToolButton (button1.get_group ());
		button2.set_icon_widget (img);
		bar.add (button2);

		button1.clicked.connect (() => {
			print ("Button 1, clicked\n");
		});

		button2.clicked.connect (() => {
			print ("Button 2, clicked\n");
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
