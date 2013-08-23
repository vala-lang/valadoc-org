public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 200);
	Cairo.Context context = new Cairo.Context (surface);
	context.set_line_width (1);

	// Line:
	context.set_source_rgba (0, 0, 0, 1);
	context.move_to (10, 10);
	context.line_to (10, 190);
	context.line_to (190, 190);
	context.stroke ();

	// Curve:
	context.move_to (10, 10);
	context.set_source_rgba (1, 0, 0, 1);
	context.rel_curve_to (0, 0, 0, 180, 180, 180);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
