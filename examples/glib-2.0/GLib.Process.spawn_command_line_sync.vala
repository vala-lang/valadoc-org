public static int main (string[] args) {
	string ls_stdout;
	string ls_stderr;
	int ls_status;

	try {
		Process.spawn_command_line_sync ("ls",
									out ls_stdout,
									out ls_stderr,
									out ls_status);

		// Output: <File list>
		stdout.printf ("stdout:\n");
		// Output: ````
		stdout.puts (ls_stdout);
		stdout.printf ("stderr:\n");
		stdout.puts (ls_stderr);
		// Output: ``0``
		stdout.printf ("status: %d\n", ls_status);
	} catch (SpawnError e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
