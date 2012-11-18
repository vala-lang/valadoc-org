public static int main (string[] args) {
	// Output: ``../my/dir/my-test.txt``
	File file = File.new_for_path ("../my/dir/my-test.txt");
	string parse_name = file.get_parse_name ();
	stdout.printf ("%s\n", parse_name);
	return 0;
}
