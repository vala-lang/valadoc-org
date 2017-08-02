public static int main () {
	MainLoop loop = new MainLoop ();

	InetAddress address = new InetAddress.from_string ("208.80.152.201");
	Resolver resolver = Resolver.get_default ();
	
	resolver.lookup_by_address_async.begin (address, null, (obj, res) => {
		try {
			// Output: ``wikipedia-lb.pmtpa.wikimedia.org`` (Wed Oct 24, 20012)
			string hostname = resolver.lookup_by_address_async.end (res);
			print ("host: %s\n", hostname);
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	// Block until loop.quit is called:
	loop.run ();
	return 0;
}
