public static int main () {
	try {
		File file = File.new_for_path (Environment.get_home_dir ());
		FileMonitor monitor = file.monitor_directory (FileMonitorFlags.NONE, null);
		stdout.printf ("Monitoring: %s\n", file.get_path ());

		monitor.changed.connect ((src, dest, event) => {
			if (dest != null) {
				stdout.printf ("%s: %s, %s\n", event.to_string (), src.get_path (), dest.get_path ());
			} else {
				stdout.printf ("%s: %s\n", event.to_string (), src.get_path ());
			}
		});

		new MainLoop ().run ();
	} catch (Error err) {
		stdout.printf ("Error: %s\n", err.message);
	}
	return 0;
}
