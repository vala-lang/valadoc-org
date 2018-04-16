public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 40);
	Cairo.Context context = new Cairo.Context (surface);

	// Draw lines:
	double x1;
	double y1;
	double x2;
	double y2;

	context.set_source_rgba (1, 0, 0, 1);
	context.set_line_width (1);

	context.move_to (10, 10);
	context.line_to (190, 10);
	context.line_to (190, 20);

	// Output: ``10.000000, 9.500000, 190.500000, 20.000000``
	context.stroke_extents (out x1, out y1, out x2, out y2);
	print ("%f, %f, %f, %f\n", x1, y1, x2, y2);

	// Output: ``false``
	bool tmp = context.in_stroke (180, 15);
	print ("%s\n", tmp.to_string ());

	// Output: ``false``
	tmp = context.in_stroke (180, 5);
	print ("%s\n", tmp.to_string ());

	// Output: ``true``
	tmp = context.in_stroke (20, 10);
	print ("%s\n", tmp.to_string ());

	context.close_path ();
	context.stroke ();

	// Extents-box:
	context.set_source_rgba (0, 0, 0, 1);
	context.rectangle (x1, y1, x2, y2);
	context.stroke ();

	// point (180, 15)
	context.arc (180, 15, 2, 0, 2*Math.PI);
	context.fill ();

	// point (180, 5)
	context.set_source_rgba (0, 0, 0, 1);
	context.arc (180, 5, 2, 0, 2*Math.PI);
	context.fill ();

	// point (20, 10)
	context.set_source_rgba (0, 0, 0, 1);
	context.arc (20, 10, 2, 0, 2*Math.PI);
	context.fill ();


	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
