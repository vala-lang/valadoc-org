public static int main (string[] args) {
	// Open or create a file for appending:
	File file = File.new_for_path ("my-test.txt");
	try {
		// Append a new line on each run:
		FileOutputStream os = file.append_to (FileCreateFlags.NONE);
		os.write ("My new line\n".data);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
