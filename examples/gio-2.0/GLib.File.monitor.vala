public static int main () {
	try {
		File file = File.new_for_path (Environment.get_home_dir ());
		FileMonitor monitor = file.monitor (FileMonitorFlags.NONE, null);
		print ("Monitoring: %s\n", file.get_path ());

		monitor.changed.connect ((src, dest, event) => {
			if (dest != null) {
				print ("%s: %s, %s\n", event.to_string (), src.get_path (), dest.get_path ());
			} else {
				print ("%s: %s\n", event.to_string (), src.get_path ());
			}
		});

		new MainLoop ().run ();
	} catch (Error err) {
		print ("Error: %s\n", err.message);
	}
	return 0;
}
