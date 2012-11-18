public static int main (string[] args) {
	Gtk.init (ref args);

	Gtk.FileChooserDialog dialog = new Gtk.FileChooserDialog ("Select a File", null, Gtk.FileChooserAction.OPEN);

	Gtk.FileFilter filter = new Gtk.FileFilter ();
	filter.set_filter_name ("All Files");
	filter.add_pattern ("*");
	dialog.add_filter (filter);

	filter = new Gtk.FileFilter ();
	filter.set_filter_name ("Images");
	filter.add_pattern ("*.png");
	filter.add_pattern ("*.jpg");
	filter.add_pattern ("*.bmp");
	dialog.add_filter (filter);

	filter = new Gtk.FileFilter ();
	filter.set_filter_name ("Audio");
	filter.add_pattern ("*.ogg");
	filter.add_pattern ("*.flac");
	dialog.add_filter (filter);

	dialog.run ();
	dialog.destroy ();
	return 0;
}
