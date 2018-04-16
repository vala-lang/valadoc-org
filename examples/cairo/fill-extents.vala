public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 125, 200);
	Cairo.Context context = new Cairo.Context (surface);
	context.set_source_rgba (1, 0, 0, 1);
	context.set_line_width (1);

	// Triangle:
	double x1;
	double y1;
	double x2;
	double y2;

	context.move_to (25, 25);
	context.rel_line_to (75, 75);
	context.rel_line_to (-75, 75);
	context.close_path ();

	// Output: ``true``
	bool tmp = context.in_fill (50, 60);
	print (@"$tmp\n");

	// Output: ``false``
	tmp = context.in_fill (10, 10);
	print (@"$tmp\n");

	// Output: ``25.000000, 25.000000, 100.000000, 175.000000
	context.fill_extents (out x1, out y1, out x2, out y2);
	print ("%f, %f, %f, %f\n", x1, y1, x2, y2);
	context.fill ();


	// point (50, 50)
	context.set_source_rgba (0, 0, 0, 1);
	context.arc (50, 60, 2, 0, 2*Math.PI);
	context.fill ();

	// point (10, 10)
	context.arc (10, 10, 2, 0, 2*Math.PI);
	context.fill ();

	// Extents-box:
	context.rectangle (x1, y1, x2, y2);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
