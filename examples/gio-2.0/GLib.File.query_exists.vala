public static int main (string[] args) {
	File file = File.new_for_path ("my-test.txt");

	// Check if a particular file exists:
	bool tmp = file.query_exists ();
	if (tmp == true) {
		stdout.printf ("File exists\n");
	} else {
		stdout.printf ("File does not exist\n");
	}

	return 0;
}
