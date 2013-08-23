public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 256, 256);
	Cairo.Context context = new Cairo.Context (surface);

	// Rectangle:
	Cairo.Pattern pat1 = new Cairo.Pattern.linear (0.0, 0.0,  0.0, 256.0);
	pat1.add_color_stop_rgba (1, 0, 0, 0, 1);
	pat1.add_color_stop_rgba (0, 1, 1, 1, 1);
	context.rectangle (0, 0, 256, 256);
	context.set_source (pat1);
	context.fill ();

	// Arc:
	Cairo.Pattern pat2 = new Cairo.Pattern.radial (115.2, 102.4, 25.6, 102.4,  102.4, 128.0);
	pat2.add_color_stop_rgba (0, 1, 1, 1, 1);
	pat2.add_color_stop_rgba (1, 0, 0, 0, 1);
	context.set_source (pat2);
	context.arc (128.0, 128.0, 76.8, 0, 2 * Math.PI);
	context.fill ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
