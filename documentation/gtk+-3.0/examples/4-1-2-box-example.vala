

public class MyWindow : Gtk.Window {
	private Gtk.Box box;
	private Gtk.Button button1;
	private Gtk.Button button2;

	public MyWindow () {
		Object (title: "Hello World");

		this.box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
		this.add (this.box);

        this.button1 = new Gtk.Button.with_label ("Hello");
        this.button1.clicked.connect (this.on_button1_clicked);

        this.box.pack_start (this.button1, true, true, 0);

        this.button2 = new Gtk.Button.with_label ("Goodbye");
        this.button2.clicked.connect (this.on_button2_clicked);
		this.box.pack_start (this.button2, true, true, 0);
	}

    private void on_button1_clicked () {
        stdout.printf ("Hello\n");
	}

    private void on_button2_clicked () {
        stdout.printf ("Goodbye\n");
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new MyWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}

