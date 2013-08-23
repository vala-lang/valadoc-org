public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 290, 200);
	Cairo.Context context = new Cairo.Context (surface);
	context.set_source_rgba (1, 0, 0, 1);
	context.set_line_width (10);

	// Line 1:
	context.set_antialias (Cairo.Antialias.DEFAULT);
	context.move_to (10, 10);
	context.rel_line_to (170, 180);
	context.stroke ();

	// Line 2:
	context.set_antialias (Cairo.Antialias.NONE);
	context.move_to (40, 10);
	context.rel_line_to (170, 180);
	context.stroke ();

	// Line 3:
	context.set_antialias (Cairo.Antialias.GRAY);
	context.move_to (70, 10);
	context.rel_line_to (170, 180);
	context.stroke ();

	// Line 4:
	context.set_antialias (Cairo.Antialias.SUBPIXEL);
	context.move_to (100, 10);
	context.rel_line_to (170, 180);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
