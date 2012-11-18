public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ToolPalette";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (150, 200);


		// ToolPalette:
		Gtk.ToolPalette toolpalette = new Gtk.ToolPalette ();
		this.add (toolpalette);

		// ItemGroup 1
		Gtk.ToolItemGroup group = new Gtk.ToolItemGroup ("Group 1");
		toolpalette.add (group);

		Gtk.ToolButton toolbutton = new Gtk.ToolButton.from_stock (Gtk.Stock.ADD);
		group.add (toolbutton);

		toolbutton = new Gtk.ToolButton.from_stock (Gtk.Stock.DELETE);
		group.add (toolbutton);

		// ItemGroup 2
		group = new Gtk.ToolItemGroup ("Group 2");
		toolpalette.add (group);

		toolbutton = new Gtk.ToolButton.from_stock (Gtk.Stock.CANCEL);
		group.add (toolbutton);

		toolbutton = new Gtk.ToolButton.from_stock (Gtk.Stock.HOME);
		group.add (toolbutton);

		toolbutton = new Gtk.ToolButton.from_stock (Gtk.Stock.ABOUT);
		group.add(toolbutton);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
