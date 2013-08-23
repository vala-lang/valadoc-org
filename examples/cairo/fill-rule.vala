public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 256, 256);
	Cairo.Context context = new Cairo.Context (surface);

	context.set_line_width (6);

	// First part:
	context.rectangle (12, 12, 232, 70);
	context.new_sub_path ();
	context.arc (64, 64, 40, 0, 2*Math.PI);
	context.new_sub_path ();
	context.arc_negative (192, 64, 40, 0, -2*Math.PI);

	context.set_fill_rule (Cairo.FillRule.EVEN_ODD);
	context.set_source_rgb (0, 0.7, 0);
	context.fill_preserve ();
	context.set_source_rgb (0, 0, 0);
	context.stroke ();

	// Second part:
	context.translate (0, 128);
	context.rectangle (12, 12, 232, 70);
	context.new_sub_path ();
	context.arc (64, 64, 40, 0, 2*Math.PI);
	context.new_sub_path ();
	context.arc_negative (192, 64, 40, 0, -2*Math.PI);

	context.set_fill_rule (Cairo.FillRule.WINDING);
	context.set_source_rgb (0, 0, 0.9);
	context.fill_preserve ();
	context.set_source_rgb (0, 0, 0);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
