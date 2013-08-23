public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 80, 80);
	Cairo.Context context = new Cairo.Context (surface);

	// Draw a rectangle:
	context.rectangle (10, 10, 50, 50);
	context.set_source_rgba (0, 0, 0, 0.8);
	context.set_line_width (8);
	context.fill ();

	// Change some style settings inside save/restore:
	context.set_operator (Cairo.Operator.XOR);
	context.set_source_rgba (1, 0, 0, 0.8);
	context.rectangle (20, 20, 50, 50);
	context.fill ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
