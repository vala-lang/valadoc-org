public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 175, 175);
	Cairo.Context context = new Cairo.Context (surface);

	// Red box:
	context.set_source_rgba (1, 0, 0, 1);
	context.rectangle (25, 25, 75, 75);
	context.fill ();

	// Blue box:
	context.set_source_rgba (0, 0, 1, 1);
	context.rectangle (75, 75, 75, 75);
	context.fill ();

	// Save the image:
	surface.write_to_png ("filled-box.png");

	return 0;
}
