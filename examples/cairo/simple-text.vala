public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 180, 40);
	Cairo.Context context = new Cairo.Context (surface);

	// Text:
	context.set_source_rgb (0.1, 0.1, 0.1); 
	context.select_font_face ("Adventure", Cairo.FontSlant.NORMAL, Cairo.FontWeight.BOLD);
	context.set_font_size (20);
	context.move_to (20, 30);
	context.show_text ("Indiana Jones");  

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
