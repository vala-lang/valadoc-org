public static int main (string[] args) {
	Gtk.init (ref args);

	Gtk.Window window = new Gtk.Window ();
	window.destroy.connect (Gtk.main_quit);
	window.set_default_size (500, 500);
	window.show_all ();

	string[] authors = {"Scrooge McDuck", "Gyro Gearloose"};

	// Use property names as keys
	Gtk.show_about_dialog (window,
		program_name: "SWMS",
		copyright: "Copyright © 1998-2000 Gyro Gearloose",
		authors: authors,
		website: "http://en.wikipedia.org/wiki/Scrooge_McDuck",
		website_label: "Scrooge McDuck and Co.");

	window.show_all ();
	Gtk.main ();
	return 0;
}
