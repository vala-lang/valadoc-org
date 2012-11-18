public static int main (string[] args) {
	// Output:
	//   ``** (process:<PID>): ERROR **: <FILENAME>:<LINE>: my 10. error``
	//   ``Trace/breakpoint trap``

	// Terminate calling process & log an error:
	error ("my %d. %s", 10, "error");
}
