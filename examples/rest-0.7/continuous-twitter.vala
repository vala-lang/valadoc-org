public class Twitter : Object {
	public void run () {
		// Create the proxy:
		Rest.OAuthProxy proxy = new Rest.OAuthProxy (
			"UfXFxDbUjk41scg0kmkFwA", // the consumer key
			"pYQlfI2ZQ1zVK0f01dnfhFTWzizBGDnhNJIw6xwto", // the consumer secret
			"https://api.twitter.com/", // the endpoint url
			false);

		// First stage authentication, this gets a request token:
		try {
			proxy.request_token ("oauth/request_token", "oob");
		} catch (Error e) {
			error ("Cannot get request token: %s", e.message);
		}

		// From the token construct a URL for the user to visit:
		print ("Go to http://twitter.com/oauth/authorize?oauth_token=%s then enter the PIN\n",
			proxy.get_token ());

		string pin = stdin.read_line ();
		pin._chomp ();


		// Second stage authentication, this gets an access token:
		try {
			proxy.access_token ("oauth/access_token", pin);
		} catch (Error e) {
			error ("Cannot get access token: %s", e.message);
		}

		//
		// We're now authenticated!
		//


		// Post the status message:
		Rest.ProxyCall call = proxy.new_call ();
		proxy.url_format = "http://stream.twitter.com/";
		call.set_function ("1/statuses/filter.json");
		call.set_method ("GET");
		call.add_param ("track", "Cameron");
		call.add_param ("delimited", "length");
		try {
			call.continuous ((call, str, len, err, obj) => {
				print (str);
				print ("\n");
			}, this);
		} catch (Error e) {
			error ("continuous: %s", e.message);
		}
	}

	public static int main (string[] args) {
		MainLoop loop = new MainLoop ();

		Twitter twitter = new Twitter ();
		twitter.run ();

		loop.run ();
		twitter = null;

		return 0;
	}
}
