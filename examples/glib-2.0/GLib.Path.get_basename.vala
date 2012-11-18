public static int main (string[] args) {
	// Output: ``path.txt``
	string res = Path.get_basename ("/my/absolute/path.txt");
	stdout.printf ("%s\n", res);

	// Output: ``path.txt``
	res = Path.get_basename ("../my/absolute/path.txt");
	stdout.printf ("%s\n", res);

	return 0;
}
