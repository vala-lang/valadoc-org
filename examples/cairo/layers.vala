public static int main (string[] args) {
	// Layer 1:
	Cairo.ImageSurface surface1 = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 200);
	Cairo.Context context1 = new Cairo.Context (surface1);

	context1.set_source_rgba (1, 0, 0, 1);
	context1.set_line_width (5);
	context1.move_to (0, 0);
	context1.line_to (200, 200);
	context1.stroke ();

	// Layer 2:
	Cairo.ImageSurface surface2 = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 200);
	Cairo.Context context2 = new Cairo.Context (surface2);

	context2.set_source_rgba (0, 0, 1, 1);
	context2.set_line_width (5);
	context2.move_to (200, 0);
	context2.line_to (0, 200);
	context2.stroke ();

	// Joined:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 200, 200);
	Cairo.Context context = new Cairo.Context (surface);

	context.set_operator (Cairo.Operator.OVER);
	context.set_source_surface (context1.get_target (), 0, 1);
	context.paint ();

	context.set_operator (Cairo.Operator.OVER);
	context.set_source_surface (context2.get_target (), 0, 1);
	context.paint_with_alpha (0.5);

	surface.write_to_png ("img.png");

	return 0;
}
