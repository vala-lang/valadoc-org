// Source: http://lists.cairographics.org/archives/cairo/2008-February/013247.html
public static int main (string[] args) {
	// Prepare mask as pattern
	Cairo.ImageSurface source = new Cairo.ImageSurface (Cairo.Format.A8, 32, 32);
	Cairo.Context context_src = new Cairo.Context (source);
	context_src.set_source_rgba (0, 0, 0, 0.5);
	context_src.rectangle (4, 4, 18, 18);
	context_src.fill ();
	context_src.rectangle (10, 10, 18, 18);
	context_src.fill ();

	Cairo.Pattern pattern = new Cairo.Pattern.for_surface (source);
	pattern.set_extend (Cairo.Extend.REPEAT);

	// Paint using prepared mask
	Cairo.ImageSurface destination = new Cairo.ImageSurface (Cairo.Format.RGB24, 64, 64);
	Cairo.Context context_dest = new Cairo.Context (destination);
	context_dest.set_source_rgb (1, 1, 1);
	context_dest.mask (pattern);

	destination.write_to_png ("img.png");

	return 0;
}
