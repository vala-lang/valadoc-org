public static void example_sync () {
	InetAddress address = new InetAddress.from_string ("208.80.152.201");
	InetSocketAddress socket_address = new InetSocketAddress (address, 80);

	try {
		SocketAddressEnumerator en = socket_address.enumerate ();
		for (SocketAddress add = en.next (); add != null; add = en.next ()) {
			print ("%s\n", add.get_family ().to_string ());
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
}

public async void example_async () {
	InetAddress address = new InetAddress.from_string ("208.80.152.201");
	InetSocketAddress socket_address = new InetSocketAddress (address, 80);

	try {
		SocketAddressEnumerator en = socket_address.enumerate ();
		for (SocketAddress add = yield en.next_async (); add != null; add = yield en.next_async ()) {
			print ("%s\n", add.get_family ().to_string ());
		}
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
}

public static int main (string[] args) {
	// Output: ``G_SOCKET_FAMILY_IPV4`` (15. Nov. 2012)
	example_sync ();

	// Output: ``G_SOCKET_FAMILY_IPV4`` (15. Nov. 2012)
	MainLoop loop = new MainLoop ();
	example_async.begin ((obj, res) => {
		loop.quit ();
	});
	loop.run ();
	return 0;
}
