


public class ProgressBarWindow : Gtk.Window {
	private Gtk.ProgressBar progressbar;

	private Gtk.CheckButton show_text_button;
	private Gtk.CheckButton activity_button;
	private Gtk.CheckButton rl_button;

	private bool activity_mode;
	private uint timeout_id;

    public ProgressBarWindow () {
        Object (title: "ProgressBar Demo");
        this.set_border_width (10);

        var vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
        this.add (vbox);

        this.progressbar = new Gtk.ProgressBar ();
        vbox.pack_start (this.progressbar, true, true, 0);

        this.show_text_button = new Gtk.CheckButton.with_label ("Show text");
        this.show_text_button.toggled.connect (this.on_show_text_toggled);
        vbox.pack_start (this.show_text_button, true, true, 0);

        this.activity_button = new Gtk.CheckButton.with_label ("Activity mode");
        this.activity_button.toggled.connect (this.on_activity_mode_toggled);
        vbox.pack_start (this.activity_button, true, true, 0);

        this.rl_button = new Gtk.CheckButton.with_label ("Right to Left");
        this.rl_button.toggled.connect (this.on_right_to_left_toggled);
        vbox.pack_start (this.rl_button, true, true, 0);

        this.timeout_id = Timeout.add (50, this.on_timeout, 0);
        this.activity_mode = false;
	}

    private void on_show_text_toggled () {
        bool show_text = show_text_button.get_active ();

		string? text;
        if (show_text) {
            text = "some text";
        } else {
            text = null;
		}

        this.progressbar.set_text (text);
        this.progressbar.set_show_text (show_text);
	}

    private void on_activity_mode_toggled () {
        this.activity_mode = activity_button.get_active ();
        if (this.activity_mode) {
            this.progressbar.pulse ();
        } else {
            this.progressbar.set_fraction (0.0);
		}
	}

    private void on_right_to_left_toggled () {
        var val = this.rl_button.get_active ();
        this.progressbar.set_inverted (val);
	}

	/**
	 * Update value on the progress bar
	 */
    private bool on_timeout () {
        if (this.activity_mode) {
            this.progressbar.pulse ();
        } else {
            var new_value = this.progressbar.get_fraction () + 0.01;

            if (new_value > 1) {
                new_value = 0;
			}

            this.progressbar.set_fraction (new_value);
		}

        // As this is a timeout function, return true so that it
        // continues to get called
        return true;
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new ProgressBarWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}

