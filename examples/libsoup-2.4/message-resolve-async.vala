public static int main (string[] args) {
	MainLoop loop = new MainLoop ();
	MainContext context = loop.get_context ();

	Soup.Address address = new Soup.Address ("www.gnome.org", 80);

	Cancellable cancellable = new Cancellable ();
	// Use cancellable.cancel () to abort the resolution

	address.resolve_async (context, cancellable, (addr, status) => {
		switch (status) {
		case Soup.Status.OK:
			print ("Resolved! %s\n", addr.get_physical ());
			break;

		case Soup.Status.CANT_RESOLVE:
			print ("Error: Unable to resolve destination host name.\n");
			break;

		case Soup.Status.CANCELLED:
			print ("Error: Message was cancelled locally.\n");
			break;

		default:
			assert_not_reached ();
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
