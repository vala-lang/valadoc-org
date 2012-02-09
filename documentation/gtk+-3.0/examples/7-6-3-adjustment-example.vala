


public class SpinButtonWindow : Gtk.Window {
	private Gtk.SpinButton spinbutton;

	private Gtk.CheckButton check_numeric;
	private Gtk.CheckButton check_ifvalid;

	private Gtk.Box hbox;

    public SpinButtonWindow () {
        Object (title: "SpinButton Demo");
        this.set_border_width (10);

        this.hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        this.add (this.hbox);

        var adjustment = new Gtk.Adjustment (0, 0, 100, 1, 10, 0);

        this.spinbutton = new Gtk.SpinButton (adjustment, 1, 2);
        this.spinbutton.set_adjustment (adjustment);
        this.hbox.pack_start (this.spinbutton, false, false, 0);

        this.check_numeric = new Gtk.CheckButton.with_label ("Numeric");
        this.check_numeric.toggled.connect (this.on_numeric_toggled);
        this.hbox.pack_start (this.check_numeric, false, false, 0);

        this.check_ifvalid = new Gtk.CheckButton.with_label ("If Valid");
        this.check_ifvalid.toggled.connect (this.on_ifvalid_toggled);
        this.hbox.pack_start (this.check_ifvalid, false, false, 0);
	}

    private void on_numeric_toggled () {
        this.spinbutton.set_numeric (check_numeric.get_active());
	}

    private void on_ifvalid_toggled () {
		Gtk.SpinButtonUpdatePolicy policy;

        if (check_ifvalid.get_active()) {
            policy = Gtk.SpinButtonUpdatePolicy.IF_VALID;
        } else {
            policy = Gtk.SpinButtonUpdatePolicy.ALWAYS;
		}

        this.spinbutton.set_update_policy (policy);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new SpinButtonWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}



