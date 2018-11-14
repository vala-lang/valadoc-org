[GtkTemplate (ui = "/foo/bar/Gtk.Builder.ui")]
public class BarWindow : Gtk.Window {
	public string text {
		get { return entry.text; }
		set { entry.text = value; }
	}

	[GtkChild]
	private Gtk.Entry entry;

	[GtkCallback]
	private void button_clicked (Gtk.Button button) {
		message ("Button clicked, entry with text: %s", entry.text);
	}

	[GtkCallback]
	private void entry_changed (Gtk.Editable editable) {
		message ("Entry changed, text: %s\n", entry.text);

		notify_property ("text");
	}
}

public void main (string[] args) {
	Gtk.init (ref args);

	var app = new BarWindow ();
	app.show_all ();
	Gtk.main ();
}
