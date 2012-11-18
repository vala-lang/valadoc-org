public static int main (string[] args) {
	try {
		AppInfo appinfo = AppInfo.get_default_for_type ("text/x-vala", true); 
		stdout.printf ("%s\n", appinfo.supports_files ().to_string ());
		stdout.printf ("%s\n", appinfo.supports_uris ().to_string ());
		stdout.printf ("%s\n", appinfo.get_commandline ());
		stdout.printf ("%s\n", appinfo.get_name ());
		appinfo.launch (null, null);
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}
	return 0;
}
