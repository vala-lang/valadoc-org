public static int main (string[] args) {
	File file = File.new_for_path ("my-test.txt");

	// Check if a particular file exists:
	bool tmp = file.query_exists ();
	if (tmp == true) {
		print ("File exists\n");
	} else {
		print ("File does not exist\n");
	}

	return 0;
}
