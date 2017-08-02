public static int main () {
	try {
		Resolver resolver = Resolver.get_default ();
		List<SrvTarget> targets = resolver.lookup_service ("pop3", "tcp", "gmail.com", null);

		foreach (SrvTarget target in targets) {
			print ("host: %s\n", target.get_hostname ());
			print ("  port: %hu\n", target.get_port ());
			print ("  priority: %hu\n", target.get_priority ());
			print ("  weight: %hu\n", target.get_weight ());
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
