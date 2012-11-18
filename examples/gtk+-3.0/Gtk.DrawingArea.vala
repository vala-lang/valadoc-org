public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.DrawingArea";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (400, 400);

		// The drawing area:
		Gtk.DrawingArea drawing_area = new Gtk.DrawingArea ();
		drawing_area.draw.connect ((context) => {
			// Get necessary data:
			weak Gtk.StyleContext style_context = drawing_area.get_style_context ();
			int height = drawing_area.get_allocated_height ();
			int width = drawing_area.get_allocated_width ();
			Gdk.RGBA color = style_context.get_color (0);

			// Draw an arc:
			double xc = width / 2.0;
			double yc = height / 2.0;
			double radius = int.min (width, height) / 2.0;
			double angle1 = 0;
			double angle2 = 2*Math.PI;

			context.arc (xc, yc, radius, angle1, angle2);
			Gdk.cairo_set_source_rgba (context, color);
			context.fill ();
			return true;
		});
		this.add (drawing_area);
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
