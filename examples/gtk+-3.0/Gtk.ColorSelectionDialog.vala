public static int main (string[] args) {
	Gtk.init (ref args);

	Gtk.ColorSelectionDialog dialog = new Gtk.ColorSelectionDialog ("Select Your Favorite Color");
	if (dialog.run () == Gtk.ResponseType.OK) {
		unowned Gtk.ColorSelection widget = dialog.get_color_selection ();
		string rgba = widget.current_rgba.to_string ();
		uint alpha = widget.current_alpha;
		print ("Selection\n");
		print ("  %s\n", rgba);
		print ("  %u\n", alpha);
	}
	dialog.close ();
	return 0;
}
