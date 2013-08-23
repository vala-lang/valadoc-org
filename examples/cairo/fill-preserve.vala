public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 256, 256);
	Cairo.Context context = new Cairo.Context (surface);

	// The content:
	context.move_to (128.0, 25.6);
	context.line_to (230.4, 230.4);
	context.rel_line_to (-102.4, 0.0);
	context.curve_to (51.2, 230.4, 51.2, 128.0, 128.0, 128.0);
	context.close_path ();

	context.move_to (64.0, 25.6);
	context.rel_line_to (51.2, 51.2);
	context.rel_line_to (-51.2, 51.2);
	context.rel_line_to (-51.2, -51.2);
	context.close_path ();

	context.set_line_width (10.0);
	context.set_source_rgb (0, 0, 1);
	context.fill_preserve ();
	context.set_source_rgb (0, 0, 0);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
