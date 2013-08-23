public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 290, 256);
	Cairo.Context context = new Cairo.Context (surface);

	// Text:
	string utf8 = "cairo";
	double x = 25.0;
	double y = 150.0;

	context.select_font_face ("Sans", Cairo.FontSlant.NORMAL, Cairo.FontWeight.NORMAL);

	Cairo.TextExtents extents;
	context.set_font_size (100.0);
	context.text_extents (utf8, out extents);

	context.move_to (x,y);
	context.show_text (utf8);

	// Draw helping lines:
	context.set_source_rgba (1, 0.2, 0.2, 0.6);
	context.set_line_width (6.0);
	context.arc (x, y, 10.0, 0, 2*Math.PI);
	context.fill ();
	context.move_to (x,y);
	context.rel_line_to (0, -extents.height);
	context.rel_line_to (extents.width, 0);
	context.rel_line_to (extents.x_bearing, -extents.y_bearing);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
