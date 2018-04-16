public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.MessageDialog";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// The MessageDialog
		Gtk.MessageDialog msg = new Gtk.MessageDialog (this, Gtk.DialogFlags.MODAL, Gtk.MessageType.WARNING, Gtk.ButtonsType.OK_CANCEL, "My message!");
			msg.response.connect ((response_id) => {
			switch (response_id) {
				case Gtk.ResponseType.OK:
					print ("Ok\n");
					break;
				case Gtk.ResponseType.CANCEL:
					print ("Cancel\n");
					break;
				case Gtk.ResponseType.DELETE_EVENT:
					print ("Delete\n");
					break;
			}

			msg.destroy();
		});
		msg.show ();
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
