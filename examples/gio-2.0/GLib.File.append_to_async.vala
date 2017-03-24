public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	// Open or create a file for appending:
	File file = File.new_for_path ("my-test.txt");
	file.append_to_async.begin (FileCreateFlags.NONE, Priority.DEFAULT, null, (obj, res) => {;
		try {
			// Append a new line on each run:
			FileOutputStream os = file.append_to_async.end (res);
			os.write ("My new line\n".data);
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
