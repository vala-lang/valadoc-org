public static int main (string[] args) {
	// Output: ``file``
	File file = File.new_for_path ("../my/dir/my-test.txt");
	string parse_name = file.get_uri_scheme ();
	print ("%s\n", parse_name);
	return 0;
}
