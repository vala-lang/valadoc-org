public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		// Don't get confused with GLib.message (format, ..)
		Test.message ("use --verbose to print messages");
		Test.message ("printf %s%c", "style", '!');
	});

	Test.run ();
	return 0;
}
