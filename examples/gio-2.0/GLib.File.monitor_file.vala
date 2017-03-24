public static int main (string[] args) {
	try {
		File file = File.new_for_path ("test.txt");
		FileMonitor monitor = file.monitor_file (FileMonitorFlags.NONE, null);
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
