public static int main (string[] args) {
	// Output: ``../my/dir/my-test.txt``
	File file = File.new_for_path ("../my/dir/my-test.txt");
	string parse_name = file.get_parse_name ();
	print ("%s\n", parse_name);

	File file2 = File.parse_name (parse_name);
	// ...
	file2 = null;
	return 0;
}
