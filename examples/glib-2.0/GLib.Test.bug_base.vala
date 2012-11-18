public static int main (string[] args) {
	Test.init (ref args);
 	Test.bug_base ("http://bugzilla.gnome.org/");

	Test.add_func ("/libvaladoc/driver-0.12.x", () => {
		// Output: ``(MSG: Bug Reference: http://bugzilla.gnome.org/504142)``
		// Only visible with ./test --verbose!
		Test.bug ("504142");
	});

	Test.run ();
	return 0;
}
