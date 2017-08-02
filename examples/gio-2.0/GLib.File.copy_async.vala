public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	// Copy my-test-1.txt to my-test-2.txt:
	File file1 = File.new_for_path ("my-test-1.txt");
	File file2 = File.new_for_path ("my-test-2.txt");
	file1.copy_async.begin (file2, 0, Priority.DEFAULT, null, (current_num_bytes, total_num_bytes) => {
		// Report copy-status:
		print ("%" + int64.FORMAT + " bytes of %" + int64.FORMAT + " bytes copied.\n",
			current_num_bytes, total_num_bytes);
	}, (obj, res) => {
		try {
			bool tmp = file1.copy_async.end (res);
			print ("Result: %s\n", tmp.to_string ());
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
