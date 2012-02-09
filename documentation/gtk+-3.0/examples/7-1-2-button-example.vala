
public class ButtonWindow : Gtk.Window {
	private Gtk.Box hbox;

	public ButtonWindow () {
		Object (title: "Button Demo");
		this.set_border_width (10);

		this.hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
		this.add (this.hbox);

		var button = new Gtk.Button.with_label ("Click Me");
		button.clicked.connect (this.on_click_me_clicked);
		hbox.pack_start (button, true, true, 0);

		button = new Gtk.Button.from_stock (Gtk.Stock.OPEN);
		button.clicked.connect (this.on_open_clicked);
		this.hbox.pack_start (button, true, true, 0);

		button = new Gtk.Button.with_mnemonic ("_Close");
		button.clicked.connect (this.on_close_clicked);
		button.use_underline = true;
		this.hbox.pack_start (button, true, true, 0);
	}

	public void on_click_me_clicked () {
		stdout.printf ("\"Click me\" button was clicked\n");
	}

	public void on_open_clicked () {
		stdout.printf ("\"Open\" button was clicked\n");
	}

	public void on_close_clicked () {
		stdout.printf ("Closing application\n");
		Gtk.main_quit ();
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new ButtonWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}

