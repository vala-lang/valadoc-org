public static int main (string[] args) {
	// Output: ``path.txt``
	string res = Path.get_basename ("/my/absolute/path.txt");
	print ("%s\n", res);

	// Output: ``path.txt``
	res = Path.get_basename ("../my/absolute/path.txt");
	print ("%s\n", res);

	return 0;
}
