public static int main () {
	try {
		Resolver resolver = Resolver.get_default ();
		List<SrvTarget> targets = resolver.lookup_service ("pop3", "tcp", "gmail.com", null);

		foreach (SrvTarget target in targets) {
			stdout.printf ("host: %s\n", target.get_hostname ());
			stdout.printf ("  port: %hu\n", target.get_port ());
			stdout.printf ("  priority: %hu\n", target.get_priority ());
			stdout.printf ("  weight: %hu\n", target.get_weight ());
		}
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
