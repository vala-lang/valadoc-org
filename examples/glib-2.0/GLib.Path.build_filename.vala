public static int main (string[] args) {
	// Output: ``my/full/path/to.txt``
	string path = Path.build_filename ("my", "full", "path/to.txt");
	print ("%s\n", path);
	return 0;
}
