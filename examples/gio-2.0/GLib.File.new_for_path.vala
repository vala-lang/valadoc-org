public static int main (string[] args) {
	// Create a file that can only be accessed by the current user:
	File file = File.new_for_path ("my-test.txt");
	try {
		FileOutputStream os = file.create (FileCreateFlags.PRIVATE);
		os.write ("My first line\n".data);
		stdout.printf ("Created.\n");
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
