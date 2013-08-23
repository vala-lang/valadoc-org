public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 200);
	Cairo.Context context = new Cairo.Context (surface);

	context.set_source_rgba (0, 0, 0, 1);
	context.set_line_width (1);

	// The rectangle:
	context.move_to (10, 10);
	context.rel_line_to (180, 0);
	context.rel_line_to (0, 180);
	context.rel_line_to (-180, 0);
	context.close_path ();
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
