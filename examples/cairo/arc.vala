public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 256, 256);
	Cairo.Context context = new Cairo.Context (surface);


	// Coordinates:
	double xc = 128.0;
	double yc = 128.0;
	double radius = 100.0;
	double angle1 = 45.0  * (Math.PI/180.0); // angles are specified
	double angle2 = 180.0 * (Math.PI/180.0); // in radians

	// The arc:
	context.set_line_width (10.0);
	context.arc (xc, yc, radius, angle1, angle2);
	context.stroke ();

	// Center:
	context.set_source_rgba (1, 0.2, 0.2, 0.6);
	context.set_line_width (6.0);
	context.arc (xc, yc, 10.0, 0, 2*Math.PI);
	context.fill ();

	// Draw helping lines:
	context.arc (xc, yc, radius, angle1, angle1);
	context.line_to (xc, yc);
	context.arc (xc, yc, radius, angle2, angle2);
	context.line_to (xc, yc);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
