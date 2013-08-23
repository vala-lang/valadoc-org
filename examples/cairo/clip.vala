public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 256, 256);
	Cairo.Context context = new Cairo.Context (surface);

	// The arc:
	context.arc (128.0, 128.0, 76.8, 0, 2 * Math.PI);
	context.clip ();

	// The X:
	context.new_path (); // current path is not
						 //consumed by clip()
	context.rectangle (0, 0, 256, 256);
	context.fill ();
	context.set_source_rgb (0, 1, 0);
	context.move_to (0, 0);
	context.line_to (256, 256);
	context.move_to (256, 0);
	context.line_to (0, 256);
	context.set_line_width (10.0);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
