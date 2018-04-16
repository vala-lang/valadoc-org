public static int main (string[] args) {
	// Output: ``./GLib.FileUtils.test``
	print ("%s\n", args[0]);

	// true if the file is a regular file (not a directory) or a symlink to a regular file.
	// Output: ``true``
	bool tmp = FileUtils.test (args[0], FileTest.IS_REGULAR);
	print ("%s\n", tmp.to_string ());

	// true if the file is a symlink. 
	// Output: ``false``
	tmp = FileUtils.test (args[0], FileTest.IS_SYMLINK);
	print ("%s\n", tmp.to_string ());

	// true if the file is a directory. 
	// Output: ``false``
	tmp = FileUtils.test (args[0], FileTest.IS_DIR);
	print ("%s\n", tmp.to_string ());

	// true if the file is a executable. 
	// Output: ``true``
	tmp = FileUtils.test (args[0], FileTest.IS_EXECUTABLE);
	print ("%s\n", tmp.to_string ());

	// true if the file exists. It may or may not be a regular file. 
	// Output: ``true``
	tmp = FileUtils.test (args[0], FileTest.EXISTS);
	print ("%s\n", tmp.to_string ());

	return 0;
}
