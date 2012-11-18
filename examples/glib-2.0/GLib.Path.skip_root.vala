public static int main (string[] args) {
	// Output: ``my/absolute/path.txt``
	string res = Path.skip_root ("/my/absolute/path.txt");
	stdout.printf ("%s\n", res);

	// Output: ``(null)``
	res = Path.skip_root ("../my/absolute/path.txt");
	stdout.printf ("%s\n", res);

	// Output: ``(null)``
	res = Path.skip_root ("./my/absolute/path.txt");
	stdout.printf ("%s\n", res);
	return 0;
}
