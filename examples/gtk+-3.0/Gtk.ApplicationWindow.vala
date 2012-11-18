public class MyApplication : Gtk.Application {
	public MyApplication () {
		Object(application_id: "testing.my.application",
				flags: ApplicationFlags.FLAGS_NONE);
	}

	protected override void activate () {
		// Create the window of this application and show it
		Gtk.ApplicationWindow window = new Gtk.ApplicationWindow (this);
		window.title = "My Gtk.ApplicationWindow";
		window.set_default_size (400, 400);

		Gtk.Label label = new Gtk.Label ("Hello, GTK");
		window.add (label);
		window.show_all ();
	}

	public static int main (string[] args) {
		MyApplication app = new MyApplication ();
		return app.run (args);
	}
}

