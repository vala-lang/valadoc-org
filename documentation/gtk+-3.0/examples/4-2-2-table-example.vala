

public class TableWindow : Gtk.Window {
	private Gtk.Table table;

    public TableWindow () {
        Object (title: "Table Example");

        this.table = new Gtk.Table (3, 3, true);
        this.add(table);

        var button1 = new Gtk.Button.with_label ("Button 1");
        var button2 = new Gtk.Button.with_label ("Button 2");
        var button3 = new Gtk.Button.with_label ("Button 3");
        var button4 = new Gtk.Button.with_label ("Button 4");
        var button5 = new Gtk.Button.with_label ("Button 5");
        var button6 = new Gtk.Button.with_label ("Button 6");

        this.table.attach_defaults (button1, 0, 1, 0, 1);
        this.table.attach_defaults (button2, 1, 3, 0, 1);
        this.table.attach_defaults (button3, 0, 1, 1, 3);
        this.table.attach_defaults (button4, 1, 3, 1, 2);
        this.table.attach_defaults (button5, 1, 2, 2, 3);
        this.table.attach_defaults (button6, 2, 3, 2, 3);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new TableWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}

