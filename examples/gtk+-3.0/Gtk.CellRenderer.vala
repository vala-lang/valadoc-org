class MyCellRenderer : Gtk.CellRenderer {
	// icon property set by the tree column
	public Gdk.Pixbuf icon { get; set; }

	public MyCellRenderer () {
		GLib.Object ();
	}

	// get_size method, always request a 50x50 area
	public override void get_size (Gtk.Widget widget, Gdk.Rectangle? cell_area,
								   out int x_offset, out int y_offset,
								   out int width, out int height)
	{
		x_offset = 0;
		y_offset = 0;
		width = 50;
		height = 50;
	}

	// render method
	public override void render (Cairo.Context ctx, Gtk.Widget widget,
								 Gdk.Rectangle background_area,
								 Gdk.Rectangle cell_area,
								 Gtk.CellRendererState flags)
	{
		Gdk.cairo_rectangle (ctx, background_area);
		if (icon != null) {
			// draw a pixbuf on a cairo context
			Gdk.cairo_set_source_pixbuf (ctx, icon,
										 background_area.x,
										 background_area.y);
			ctx.fill ();
		}
	}
}

Gdk.Pixbuf open_image (string file) {
	try {
		return new Gdk.Pixbuf.from_file (file);
	} catch (Error e) {
		error ("%s", e.message);
	}
}

public static int main (string[] args) {
	if (args[1] == null) {
		print ("Error: Use: ./Gtk.CellRenderer <filename>\n");
		return 0;
	}

	Gtk.init (ref args);

	// The TreeView:
	Gtk.TreeView tv = new Gtk.TreeView ();
	Gtk.ListStore tm = new Gtk.ListStore (2, typeof (Gdk.Pixbuf), typeof (string));
	tv.set_model (tm);

	Gtk.CellRenderer renderer = new MyCellRenderer ();
	Gtk.TreeViewColumn col = new Gtk.TreeViewColumn ();
	col.pack_start (renderer, true);
	col.set_title ("1st column");
	col.add_attribute (renderer, "icon", 0);
	tv.append_column (col);

	renderer = new Gtk.CellRendererText ();
	col = new Gtk.TreeViewColumn ();
	col.pack_start (renderer, true);
	col.set_title ("2nd column");
	col.add_attribute (renderer, "text", 1);
	tv.append_column (col);


	// Append data to our model:
	Gtk.TreeIter ti;
	tm.append (out ti);

	Gdk.Pixbuf pixbuf = open_image (args[1]);
	tm.set (ti, 0, pixbuf, 1, "asd", -1); 


	// The main window:
	Gtk.Window win = new Gtk.Window ();
	win.set_default_size (400, 100);
	win.destroy.connect (Gtk.main_quit);
	win.add (tv);
	win.show_all ();

	Gtk.main ();
	return 0;
}
