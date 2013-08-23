public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 40);
	Cairo.Context context = new Cairo.Context (surface);

	// Draw lines:
	context.set_source_rgba (1, 0, 0, 1);
	context.set_line_width (1);

	context.move_to (10, 10);
	context.line_to (190, 10);
	context.line_to (190, 20);

	context.move_to (10, 20);
	context.line_to (190, 20);

	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
