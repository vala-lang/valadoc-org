public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 80);
	Cairo.Context context = new Cairo.Context (surface);

	// Draw lines:
	context.set_line_width (10);

	// Line 1:
	context.set_source_rgba (0, 0, 1, 1);
	context.move_to (10, 20);
	context.rel_line_to (180, 0);
	context.stroke ();

	// Line 2:
	context.set_source_rgba (0, 0, 1, 0.5);
	context.move_to (10, 40);
	context.rel_line_to (180, 0);
	context.stroke ();

	// Line 3:
	context.set_source_rgba (0, 0, 1, 0.1);
	context.move_to (10, 60);
	context.rel_line_to (180, 0);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
