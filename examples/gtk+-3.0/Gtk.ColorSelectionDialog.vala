public static int main (string[] args) {
	Gtk.init (ref args);

	Gtk.ColorSelectionDialog dialog = new Gtk.ColorSelectionDialog ("Select Your Favorite Color");
	if (dialog.run () == Gtk.ResponseType.OK) {
		unowned Gtk.ColorSelection widget = dialog.get_color_selection ();
		string color = widget.current_color.to_string ();
		string rgba = widget.current_rgba.to_string ();
		uint alpha = widget.current_alpha;
		stdout.puts ("Selection\n");
		stdout.printf ("  %s\n", color);
		stdout.printf ("  %s\n", rgba);
		stdout.printf ("  %u\n", alpha);
	}
	dialog.close ();
	return 0;
}
