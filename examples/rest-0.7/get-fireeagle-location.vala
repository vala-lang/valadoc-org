// README: Fire Eagle has closed as of February 2013.
//  This eample won't work anymore. However, the code
//  might be useful.
public static int main (string[] args) {
	// Create the proxy:
	Rest.OAuthProxy proxy = new Rest.OAuthProxy (
		"NmUm6hxQ9a4u", // Consumer Key
		"t4FM7LiUeD4RBwKSPa6ichKPDh5Jx4kt", // Consumer Secret
		"https://fireeagle.yahooapis.com/", // FireEagle endpoint
		false);

	// First stage authentication, this gets a request token:
	try {
		proxy.request_token ("oauth/request_token", "oob");
	} catch (Error e) {
		error ("Cannot request token: %s", e.message);
	}

	// From the token construct a URL for the user to visit:
	print ("Go to https://fireeagle.yahoo.net/oauth/authorize?oauth_token=%s then enter the verification code\n",
		proxy.get_token ());

	// Read the PIN:
	string pin = stdin.read_line ();

	// Second stage authentication, this gets an access token:
	try {
		proxy.access_token ("oauth/access_token", pin);
	} catch (Error e) {
		error ("Cannot request token: %s", e.message);
	}

	// Get the user's current location:
	Rest.ProxyCall call = proxy.new_call ();
	call.set_function ("api/0.1/user");

	try {
		call.run ();
	} catch (Error e) {
		error ("Cannot make call: %s", e.message);
	}

	Rest.XmlParser parser = new Rest.XmlParser ();
	Rest.XmlNode root = parser.parse_from_data (
		call.get_payload (),
		call.get_payload_length ());

	Rest.XmlNode node = root.find ("location");
	node = node.find ("name");
	print ("%s\n", node.content);
	return 0;
}
