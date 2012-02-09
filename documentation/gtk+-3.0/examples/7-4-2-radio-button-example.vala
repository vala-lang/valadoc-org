


public class RadioButtonWindow : Gtk.Window {
	private Gtk.Box hbox;

    public RadioButtonWindow () {
        Object (title: "RadioButton Demo");
        this.set_border_width (10);

        this.hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        this.add (hbox);

        var button1 = new Gtk.RadioButton.with_label (null, "Button 1");
        button1.toggled.connect (() => { this.on_button_toggled (button1, 1); });
        hbox.pack_start (button1, false, false, 0);

        var button2 = new Gtk.RadioButton.from_widget (button1);
        button2.set_label ("Button 2");
        button2.toggled.connect (() => { this.on_button_toggled (button2, 2); });
        hbox.pack_start (button2, false, false, 0);

        var button3 = new Gtk.RadioButton.with_mnemonic_from_widget (button1, "B_utton 3");
        button3.toggled.connect (() => { this.on_button_toggled (button3, 3); });
        hbox.pack_start (button3, false, false, 0);
	}

    private void on_button_toggled (Gtk.RadioButton button, int nr) {
		string state;
        if (button.get_active()) {
            state = "on";
        } else {
            state = "off";
		}

        stdout.printf ("Button %d was turned %s\n", nr, state);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new RadioButtonWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}



