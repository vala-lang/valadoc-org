public static int main (string[] args) {
    Gtk.init (ref args);

    Gtk.Window window = new Gtk.Window ();
    window.title = "My Gtk.Clipboard";
    window.border_width = 10;
    window.set_default_size (300, 20);
    window.destroy.connect (Gtk.main_quit);

    Gtk.Entry entry = new Gtk.Entry ();
    window.add (entry);
    window.show_all ();
 
    Gdk.Display display = window.get_display ();
    Gtk.Clipboard clipboard = Gtk.Clipboard.get_for_display (display, Gdk.SELECTION_CLIPBOARD);
    // Get text from clipboard
    string text = clipboard.wait_for_text ();
    entry.text = text ?? "";

    // If the user types something ...
    entry.changed.connect (() => {
        // Set text to clipboard
        clipboard.set_text (entry.text, -1);
    });

    Gtk.main ();
    return 0;
}
