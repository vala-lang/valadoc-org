public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 256, 256);
	Cairo.Context context = new Cairo.Context (surface);

	// Content:
	string image_path = Path.build_filename (Path.get_dirname (args[0]) , "romedalen.png");
	Cairo.ImageSurface image = new Cairo.ImageSurface.from_png (image_path);
	int w = image.get_width ();
	int h = image.get_height ();

	Cairo.Pattern pattern = new Cairo.Pattern.for_surface (image);
	pattern.set_extend (Cairo.Extend.REPEAT);

	context.translate (128.0, 128.0);
	context.rotate (Math.PI / 4);
	context.scale (1 / Math.sqrt (2), 1 / Math.sqrt (2));
	context.translate (-128.0, -128.0);

	Cairo.Matrix matrix = Cairo.Matrix.identity ();
	matrix.scale (w/256.0 * 5.0, h/256.0 * 5.0);
	pattern.set_matrix (matrix);

	context.set_source (pattern);

	context.rectangle (0, 0, 256.0, 256.0);
	context.fill ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
