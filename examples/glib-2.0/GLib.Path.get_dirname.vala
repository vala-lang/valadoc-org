public static int main (string[] args) {
	// Output: ``/my/absolute/``
	string res = Path.get_dirname ("/my/absolute/path.txt");
	stdout.printf ("%s\n", res);

	// Output: ``../my/absolute/``
	res = Path.get_dirname ("../my/absolute/path.txt");
	stdout.printf ("%s\n", res);

	// Output: ``./my/absolute/``
	res = Path.get_dirname ("./my/absolute/path.txt");
	stdout.printf ("%s\n", res);
	return 0;
}
