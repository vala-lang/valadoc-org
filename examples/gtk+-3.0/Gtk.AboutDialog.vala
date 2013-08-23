public static int main (string[] args) {
	Gtk.init (ref args);

	// Create a window:
	Gtk.Window window = new Gtk.Window ();
	window.destroy.connect (Gtk.main_quit);
	window.set_default_size (500, 500);
	window.show_all ();

	// Configure the dialog:
	Gtk.AboutDialog dialog = new Gtk.AboutDialog ();
	dialog.set_destroy_with_parent (true);
	dialog.set_transient_for (window);
	dialog.set_modal (true);

	dialog.artists = {"Darkwing Duck", "Launchpad McQuack"};
	dialog.authors = {"Scrooge McDuck", "Gyro Gearloose"};
	dialog.documenters = null; // Real inventors don't document.
	dialog.translator_credits = null; // We only need a scottish version.

	dialog.program_name = "SWMS";
	dialog.comments = "Scrooges wealth management system";
	dialog.copyright = "Copyright © 1998-2000 Gyro Gearloose";
	dialog.version = "3.0";

	dialog.license = "Permission is hereby granted, NOT free of charge, ..., very long text";
	dialog.wrap_license = true;

	dialog.website = "http://en.wikipedia.org/wiki/Scrooge_McDuck";
	dialog.website_label = "Scrooge McDuck and Co.";

	dialog.response.connect ((response_id) => {
		if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
			dialog.hide_on_delete ();
		}
	});

	// Show the dialog:
	dialog.present ();
	Gtk.main ();
	return 0;
}
