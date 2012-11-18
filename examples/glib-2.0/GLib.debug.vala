public static int main (string[] args) {
	// Use "G_MESSAGES_DEBUG=all ./test" to print debug messages!

	// Output: ``** (process:<PID>): DEBUG: <FILENAME>:<LINE>: my 10. debug message``
	debug ("my %d. %s", 10, "debug message");
	return 0;
}
