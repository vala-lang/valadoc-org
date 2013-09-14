public static int main (string[] args) {
	string summary = "Short summary";
	string body = "A long description";
	// = Gtk.Stock.DIALOG_INFO
	string icon = "dialog-information";

	Notify.init ("My test app");

	try {
		Notify.Notification notification = new Notify.Notification (summary, body, icon);
		notification.show ();
	} catch (Error e) {
		error ("Error: %s", e.message);
	}
	return 0;
}
