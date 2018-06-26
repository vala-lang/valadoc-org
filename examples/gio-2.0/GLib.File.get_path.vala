public static int main (string[] args) {
	// Output: ``/home/flo/examples/my/dir/my-test.txt``
	File file = File.new_for_path ("../my/dir/my-test.txt");
	string parse_name = file.get_path ();
	print ("%s\n", parse_name);
	return 0;
}
