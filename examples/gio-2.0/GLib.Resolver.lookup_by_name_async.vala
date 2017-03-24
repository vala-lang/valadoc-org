public static int main () {
	MainLoop loop = new MainLoop ();

	Resolver resolver = Resolver.get_default ();
	resolver.lookup_by_name_async.begin ("www.google.com", null, (obj, res) => {
		try {
			// Example output:
			//  ``173.194.35.179``
			//  ``173.194.35.178``
			//  ``173.194.35.177``
			//  ``173.194.35.176``
			//  ``173.194.35.180``
			//  ``2a00:1450:4016:801::1013``
			List<InetAddress> addresses = resolver.lookup_by_name_async.end (res);
			foreach (InetAddress address in addresses) {
				print ("%s\n", address.to_string ());
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	// Block until loop.quit is called:
	loop.run ();
	return 0;
}
