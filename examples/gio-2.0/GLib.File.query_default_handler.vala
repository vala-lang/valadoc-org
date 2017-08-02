public static int main (string[] args) {
	try {
		List<string> uris = new List<string> ();
		uris.append ("http://developer.gnome.org/");

		File file = File.new_for_uri (uris.nth_data (0));
		AppInfo appinfo = file.query_default_handler ();
		appinfo.launch_uris (uris, null);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
