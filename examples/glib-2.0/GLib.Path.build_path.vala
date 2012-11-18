public static int main (string[] args) {
	// Output: ``my/full/path/to.txt``
	string path = Path.build_path (Path.DIR_SEPARATOR_S, "my", "full", "path/to.txt");
	stdout.printf ("%s\n", path);
	return 0;
}
