public static int main () {
	// Resolve hostname to IP address
	try {
		Resolver resolver = Resolver.get_default ();
		List<InetAddress> addresses = resolver.lookup_by_name ("www.google.com", null);

		// Example output:
		//  ``173.194.35.179``
		//  ``173.194.35.178``
		//  ``173.194.35.177``
		//  ``173.194.35.176``
		//  ``173.194.35.180``
		//  ``2a00:1450:4016:801::1013``
		foreach (InetAddress address in addresses) {
			print ("%s\n", address.to_string ());
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
