public static int main (string[] args) {
	//
	// Determine whether valadoc.org can be reached: (sync):
	//

	NetworkMonitor monitor = NetworkMonitor.get_default ();
	NetworkAddress address = new NetworkAddress ("www.valadoc.org", 80); 
	try {
		bool can_reach = monitor.can_reach (address);
		print ("can-reach: %s\n", can_reach.to_string ());
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
