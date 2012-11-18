public static int main () {
	// Local Output:
	//  ``SSH_AGENT_PID``
	//  ``PATH``
	//  ...
	string[] args = Environment.list_variables ();
	foreach (string arg in args) {
		stdout.printf ("%s\n", arg);
	}
	return 0;
}
