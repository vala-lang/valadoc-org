public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 40);
	Cairo.Context context = new Cairo.Context (surface);

	// Draw lines:
	context.set_source_rgba (1, 0, 0, 1);
	context.set_line_width (1);

	context.move_to (10, 10);
	context.rel_line_to (90, 0);
	context.rel_line_to (90, 5);

	context.rel_move_to (-180, 10);
	context.rel_line_to (90, 0);
	context.rel_line_to (90, 5);

	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
