public static int main (string[] args) {
	// Use "G_DEBUG=fatal-warnings ./test" to abort the program at the first
	// call to GLib.warning() or GLib.critical().

	// Output: ``** (process:<PID>): WARNING **: <FILENAME>:<LINE>: my 10. warning``
	warning ("my %d. %s", 10, "warning");
	return 0;
}
