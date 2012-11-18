public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Notebook";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (400, 400);

		// The Notebook:
		Gtk.Notebook notebook = new Gtk.Notebook ();
		this.add (notebook);

		// Tab 1:
		Gtk.Label title = new Gtk.Label ("Title 1");
		Gtk.Label content = new Gtk.Label ("Content 1");
		notebook.append_page (content, title);

		// Tab 2:
		title = new Gtk.Label ("Title 2");
		content = new Gtk.Label ("Content 2");
		notebook.append_page (content, title);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
