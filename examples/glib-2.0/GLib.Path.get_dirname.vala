public static int main (string[] args) {
	// Output: ``/my/absolute/``
	string res = Path.get_dirname ("/my/absolute/path.txt");
	print ("%s\n", res);

	// Output: ``../my/absolute/``
	res = Path.get_dirname ("../my/absolute/path.txt");
	print ("%s\n", res);

	// Output: ``./my/absolute/``
	res = Path.get_dirname ("./my/absolute/path.txt");
	print ("%s\n", res);
	return 0;
}
