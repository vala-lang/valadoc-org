public static int main (string[] args) {
	// Create a context:
	Cairo.ImageSurface surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, 256, 256);
	Cairo.Context context = new Cairo.Context (surface);

	// The arc:
	context.arc (128.0, 128.0, 76.8, 0, 2*Math.PI);
	context.clip ();
	context.new_path (); // path not consumed by clip()

	// The image:
	string image_path = Path.build_filename (Path.get_dirname (args[0]) , "romedalen.png");
	Cairo.ImageSurface image = new Cairo.ImageSurface.from_png (image_path);
	int w = image.get_width ();
	int h = image.get_height ();
	context.scale (256.0/w, 256.0/h);

	context.set_source_surface (image, 0, 0);
	context.paint ();

	// Save the image:
	surface.write_to_png ("img.png");

	return 0;
}
