public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 256, 256);
	Cairo.Context context = new Cairo.Context (surface);

	// Text:
	string utf8 = "cairo";

	context.select_font_face ("Sans", Cairo.FontSlant.NORMAL, Cairo.FontWeight.NORMAL);
	context.set_font_size (52.0);

	Cairo.TextExtents extents;
	context.text_extents (utf8, out extents);
	double x = 128.0-(extents.width/2 + extents.x_bearing);
	double y = 128.0-(extents.height/2 + extents.y_bearing);

	context.move_to (x, y);
	context.show_text (utf8);

	// Draw helping lines:
	context.set_source_rgba (1, 0.2, 0.2, 0.6);
	context.set_line_width (6.0);
	context.arc (x, y, 10.0, 0, 2*Math.PI);
	context.fill ();
	context.move_to (128.0, 0);
	context.rel_line_to (0, 256);
	context.move_to (0, 128.0);
	context.rel_line_to (256, 0);
	context.stroke ();

	// Save the image:
	surface.write_to_png ("img.png");


	return 0;
}
