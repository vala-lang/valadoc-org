public static int main (string[] args) {
	// Output: ``'rm', '-R', 'my dir',``
	try {
		string[]? argvp = null;
		Shell.parse_argv ("rm -R \"my dir\"", out argvp);
		foreach (unowned string arg in argvp) {
			print ("'%s', ", arg);
		}
		print ("\n");
	} catch (ShellError e) {
		print ("Error: %s\n", e.message);
	}

	// Output: ``Error: Text ended before matching quote was found for ". (The text was 'rm -R "my dir')``
	try {
		string[]? argvp = null;
		Shell.parse_argv ("rm -R \"my dir", out argvp);
		assert_not_reached ();
	} catch (ShellError e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
