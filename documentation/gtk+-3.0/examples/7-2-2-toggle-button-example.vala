

public class ToggleButtonWindow : Gtk.Window {

    public ToggleButtonWindow () {
        Object (title: "ToggleButton Demo");
        this.set_border_width (10);

        var hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        this.add(hbox);

        var button1 = new Gtk.ToggleButton.with_label ("Button 1");
        button1.toggled.connect (() => { this.on_button_toggled (button1, 1); });
        hbox.pack_start (button1, true, true, 0);

        var button2 = new Gtk.ToggleButton.with_mnemonic ("B_utton 2");
		button2.use_underline = true;
        button2.set_active (true);
        button2.toggled.connect (() => { this.on_button_toggled (button2, 2); });
        hbox.pack_start (button2, true, true, 0);
	}

    private void on_button_toggled (Gtk.ToggleButton button, int nr) {
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

		var win = new ToggleButtonWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all();

		Gtk.main();
		return 0;
	}
}

