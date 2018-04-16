public static int main (string[] args) {
	string summary = "Short summary";
	string body = "A long description";
	// = Gtk.Stock.DIALOG_INFO
	string icon = "dialog-information";

	Notify.init ("My test app");

	GLib.MainLoop loop = new GLib.MainLoop ();
	try {
		Notify.Notification notification = new Notify.Notification (summary, body, icon);
		notification.add_action ("action-name", "Quit", (notification, action) => {
			print ("Bye!\n");
			try {
				notification.close ();
			} catch (Error e) {
				debug ("Error: %s", e.message);
			}
			loop.quit ();
		});
		notification.show ();
		loop.run ();
	} catch (Error e) {
		error ("Error: %s", e.message);
	}
	return 0;
}
