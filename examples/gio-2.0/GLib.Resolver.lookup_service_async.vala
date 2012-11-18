public static int main () {
	MainLoop loop = new MainLoop ();

	Resolver resolver = Resolver.get_default ();
	resolver.lookup_service_async.begin ("pop3", "tcp", "gmail.com", null, (obj, res) => {
		try {
			List<SrvTarget> targets = resolver.lookup_service_async.end (res);
			foreach (SrvTarget target in targets) {
				stdout.printf ("host: %s\n", target.get_hostname ());
				stdout.printf ("  port: %hu\n", target.get_port ());
				stdout.printf ("  priority: %hu\n", target.get_priority ());
				stdout.printf ("  weight: %hu\n", target.get_weight ());
			}
		} catch (Error e) {
			stdout.printf ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	// Block until loop.quit is called:
	loop.run ();
	return 0;
}
