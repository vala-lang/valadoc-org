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
		print ("stdout:\n");
		// Output: ````
		print (ls_stdout);
		print ("stderr:\n");
		print (ls_stderr);
		// Output: ``0``
		print ("Status: %d\n", ls_status);
	} catch (SpawnError e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
