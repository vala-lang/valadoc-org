public static int main (string[] args) {
	NetworkMonitor monitor = NetworkMonitor.get_default ();

	//
	// Check whether the network is considered available:
	// (network availability != internet)
	//

	bool available = monitor.get_network_available ();
	print ("Network available: %s\n", available.to_string ());


	//
	// Determine whether valadoc.org can be reached: (sync):
	//

	NetworkAddress address = new NetworkAddress ("www.valadoc.org", 80); 
	if (available == true) {
		try {
			bool can_reach = monitor.can_reach (address);
			print ("can-reach: %s\n", can_reach.to_string ());
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}
	}


	//
	// Recheck availability when the network configuration changes:
	//

	monitor.network_changed.connect ((available) => {
		print ("Network changed (available: %s)\n", available.to_string ());

		// Determine whether valadoc.org can be reached: (async):
		if (available == true) {
			monitor.can_reach_async.begin (address, null, (obj, res) => {
				try {
					bool can_reach = monitor.can_reach_async.end (res);
					print ("can-reach: %s\n", can_reach.to_string ());
				} catch (Error e) {
					print ("Error: %s\n", e.message);
				}
			});
		}
	});

	new MainLoop ().run ();
	return 0;
}
