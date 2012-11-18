public int main (string[] args) {
	try {
		string str = "If I had some duck tape, I could fix that.";
		string old = "duck";
		string replacement = "duct";

		var regex = new GLib.Regex (GLib.Regex.escape_string (old));
		string result = regex.replace_literal (str, -1, 0, replacement);
		// Output:
		//  ``str: "If I had some duck tape, I could fix that."``
		//  ``old: "duck"``
		//  ``replacement: "duct"``
		//  ``result: "If I had some duct tape, I could fix that."``
		stdout.printf ("str: \"%s\"\n", str);
		stdout.printf ("old: \"%s\"\n", old);
		stdout.printf ("replacement: \"%s\"\n", replacement);
		stdout.printf ("result: \"%s\"\n", result);
	} catch (GLib.RegexError e) {
		GLib.assert_not_reached ();
	}

	return 0;
}
