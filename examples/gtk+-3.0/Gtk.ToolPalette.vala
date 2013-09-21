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

		Gtk.Image img = new Gtk.Image.from_icon_name ("list-add", Gtk.IconSize.SMALL_TOOLBAR);
		Gtk.ToolButton toolbutton = new Gtk.ToolButton (img, null);
		group.add (toolbutton);

		img = new Gtk.Image.from_icon_name ("dialog-password", Gtk.IconSize.SMALL_TOOLBAR);
		toolbutton = new Gtk.ToolButton (img, null);
		group.add (toolbutton);

		// ItemGroup 2
		group = new Gtk.ToolItemGroup ("Group 2");
		toolpalette.add (group);

		img = new Gtk.Image.from_icon_name ("dialog-warning-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
		toolbutton = new Gtk.ToolButton (img, null);
		group.add (toolbutton);

		img = new Gtk.Image.from_icon_name ("go-home", Gtk.IconSize.SMALL_TOOLBAR);
		toolbutton = new Gtk.ToolButton (img, null);
		group.add (toolbutton);

		img = new Gtk.Image.from_icon_name ("help-about", Gtk.IconSize.SMALL_TOOLBAR);
		toolbutton = new Gtk.ToolButton (img, null);
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
