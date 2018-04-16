public static int main (string[] args) {
	try {
		AppInfo appinfo = AppInfo.get_default_for_type ("text/x-vala", true);
		print ("%s\n", appinfo.supports_files ().to_string ());
		print ("%s\n", appinfo.supports_uris ().to_string ());
		print ("%s\n", appinfo.get_commandline ());
		print ("%s\n", appinfo.get_name ());
		appinfo.launch (null, null);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
