public static int main (string[] args) {
	// Use "G_DEBUG=fatal-warnings ./test" to abort the program at the first
	// call to GLib.warning() or GLib.critical().

	// Use "G_DEBUG=fatal-criticals ./test" to abort the program at the first
	// call to GLib.critical().

	// Output: `** (process:<PID>): CRITICAL **: <FILENAME>:<LINE>: my 10. critical``
	critical ("my %d. %s", 10, "critical");
	return 0;
}
