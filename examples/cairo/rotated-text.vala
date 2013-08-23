public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 340, 300);
	Cairo.Context context = new Cairo.Context (surface);

	// The matrix:
	Cairo.Matrix matrix = Cairo.Matrix.identity ();
	matrix.rotate (-1 * 10.0 * Math.PI /180.0);
	matrix.scale (40, 40);

	// Text:
	context.set_source_rgb (0.1, 0.1, 0.1); 
	context.select_font_face ("Adventure", Cairo.FontSlant.NORMAL, Cairo.FontWeight.BOLD);
	context.set_font_size (20);
	context.move_to (30, 200);
	context.set_font_matrix (matrix);
	context.show_text ("Indiana Jones");  

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
