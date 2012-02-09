

public class EntryWindow : Gtk.Window {
	private Gtk.Box vbox;
	private Gtk.Box hbox;

	private Gtk.CheckButton check_editable;
	private Gtk.CheckButton check_visible;
	private Gtk.CheckButton check_pulse;
	private Gtk.CheckButton check_icon;
	private Gtk.Entry entry;

	private string? stock_id;
	private uint timeout_id;

    public EntryWindow () {
        Object (title: "Entry Demo");
        this.set_size_request (200, 100);

        this.timeout_id = 0;

        this.vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
        this.add (vbox);

        this.entry = new Gtk.Entry ();
        this.entry.set_text ("Hello World");
        this.vbox.pack_start (this.entry, true, true, 0);

        this.hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        this.vbox.pack_start (hbox, true, true, 0);
        
        this.check_editable = new Gtk.CheckButton.with_label ("Editable");
        this.check_editable.toggled.connect (this.on_editable_toggled);
        this.check_editable.set_active (true);
        this.hbox.pack_start (this.check_editable, true, true, 0);

        this.check_visible = new Gtk.CheckButton.with_label ("Visible");
        this.check_visible.toggled.connect (this.on_visible_toggled);
        this.check_visible.set_active (true);
        this.hbox.pack_start (this.check_visible, true, true, 0);

        this.check_pulse = new Gtk.CheckButton.with_label ("Pulse");
        this.check_pulse.toggled.connect (this.on_pulse_toggled);
        this.check_pulse.set_active (false);
        this.hbox.pack_start (this.check_pulse, true, true, 0);

        this.check_icon = new Gtk.CheckButton.with_label ("Icon");
        this.check_icon.toggled.connect (this.on_icon_toggled);
        this.check_icon.set_active (false);
        this.hbox.pack_start (this.check_icon, true, true, 0);
	}

    private void on_editable_toggled () {
        var val = check_editable.get_active ();
        this.entry.set_editable (val);
	}

    private void on_visible_toggled () {
        var val = check_visible.get_active ();
        this.entry.set_visibility (val);
	}

    private void on_pulse_toggled () {
        if (check_pulse.get_active ()) {
            this.entry.set_progress_pulse_step (0.2);
            // Call this.do_pulse every 100 ms
            this.timeout_id = Timeout.add (100, do_pulse, Priority.DEFAULT);

        } else {
            // Don't call this.do_pulse anymore
            Source.remove (this.timeout_id);
            this.timeout_id = 0;
            this.entry.set_progress_pulse_step (0);
		}
	}

    private bool do_pulse () {
        this.entry.progress_pulse ();
        return true;
	}

    private void on_icon_toggled () {
        if (check_icon.get_active ()) {
            this.stock_id = Gtk.Stock.FIND;
        } else {
            this.stock_id = null;
		}

        this.entry.set_icon_from_stock (Gtk.EntryIconPosition.PRIMARY, this.stock_id);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new EntryWindow ();
		win.destroy.connect(Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}


