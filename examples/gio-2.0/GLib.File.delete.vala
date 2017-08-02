public static int main (string[] args) {
	// Delete my-test.txt:
	File file = File.new_for_path ("my-test.txt");
	try {
		file.delete ();
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
