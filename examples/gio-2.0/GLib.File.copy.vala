public static int main (string[] args) {
	// Copy my-test-1.txt to my-test-2.txt:
	File file1 = File.new_for_path ("my-test-1.txt");
	File file2 = File.new_for_path ("my-test-2.txt");
	try {
		file1.copy (file2, 0, null, (current_num_bytes, total_num_bytes) => {
			// Report copy-status:
			print ("%" + int64.FORMAT + " bytes of %" + int64.FORMAT + " bytes copied.\n",
				current_num_bytes, total_num_bytes);
		});
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
