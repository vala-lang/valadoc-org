public static int main () {
	try {
		// Output: ``wikipedia-lb.pmtpa.wikimedia.org`` (Wed Oct 24, 20012)
		InetAddress address = new InetAddress.from_string ("208.80.152.201");
		Resolver resolver = Resolver.get_default ();
		string hostname = resolver.lookup_by_address (address, null);
		stdout.printf ("host: %s\n", hostname);
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
