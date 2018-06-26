public static int main (string[] args) {
	try {
		string[] spawn_args = {"ls", "-l", "-h"};
		string[] spawn_env = Environ.get ();
		string ls_stdout;
		string ls_stderr;
		int ls_status;

		Process.spawn_sync ("/",
							spawn_args,
							spawn_env,
							SpawnFlags.SEARCH_PATH,
							null,
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
		print ("status: %d\n", ls_status);

	} catch (SpawnError e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
