public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	// Delete my-test.txt:
	File file = File.new_for_path ("my-test.txt");
	file.delete_async.begin (Priority.DEFAULT, null, (obj, res) => {
		try {
			bool tmp = file.delete_async.end (res);
			print ("Result: %s\n", tmp.to_string ());
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
