public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 500, 500);
	Cairo.Context context = new Cairo.Context (surface);

	// Transformation 1:
	Cairo.Matrix matrix1 = Cairo.Matrix.identity ();
	matrix1.translate (250, 250);
	context.transform (matrix1);

	// Transformation 2:
	Cairo.Matrix matrix2 = Cairo.Matrix.identity ();
	matrix2.scale (1, -1);
	context.transform (matrix2);

	// Y-Axis:
	context.move_to (-250, 0);
	context.line_to (250, 0);
	context.stroke ();

	// X-Axis:
	context.move_to (0, -250);
	context.line_to (0, 250);
	context.stroke ();

	// P (20, 10)
	context.set_source_rgba (0, 0, 0, 1);
	context.arc (20, 10, 2, 0, 2*Math.PI);
	context.fill ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
