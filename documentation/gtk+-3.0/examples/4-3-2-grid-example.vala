

public class GridWindow : Gtk.Window {
	private Gtk.Grid grid;

    public GridWindow () {
        Object (title: "Grid Example");

        this.grid = new Gtk.Grid ();
        this.add (grid);

        var button1 = new Gtk.Button.with_label ("Button 1");
        var button2 = new Gtk.Button.with_label ("Button 2");
        var button3 = new Gtk.Button.with_label ("Button 3");
        var button4 = new Gtk.Button.with_label ("Button 4");
        var button5 = new Gtk.Button.with_label ("Button 5");
        var button6 = new Gtk.Button.with_label ("Button 6");

        this.grid.add (button1);
        this.grid.attach (button2, 1, 0, 2, 1);
        this.grid.attach_next_to (button3, button1, Gtk.PositionType.BOTTOM, 1, 2);
        this.grid.attach_next_to (button4, button3, Gtk.PositionType.RIGHT, 2, 1);
        this.grid.attach (button5, 1, 2, 1, 1);
        this.grid.attach_next_to (button6, button5, Gtk.PositionType.RIGHT, 1, 1);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		var win = new GridWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all();

		Gtk.main();
		return 0;
	}
}
