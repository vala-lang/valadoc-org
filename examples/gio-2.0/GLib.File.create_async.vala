public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	// Create a file that can only be accessed by the current user:
	File file = File.new_for_path ("my-test.txt");
	file.create_async.begin (FileCreateFlags.PRIVATE, Priority.DEFAULT, null, (obj, res) => {
		try {
			FileOutputStream os = file.create_async.end (res);
			os.write ("My first line\n".data);
			print ("Created.\n");
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
