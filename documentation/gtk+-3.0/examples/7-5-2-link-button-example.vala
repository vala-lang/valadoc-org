

public class LinkButtonWindow : Gtk.Window {

    public LinkButtonWindow () {
        Object (title: "LinkButton Demo");
        this.set_border_width (10);

        var button = new Gtk.LinkButton.with_label ("http://www.gtk.org", "Visit GTK+ Homepage");
        this.add (button);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new LinkButtonWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}


