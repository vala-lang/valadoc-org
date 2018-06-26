public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	// Create a file for reading and writing:
	File file = File.new_for_path ("my-test.txt");
	file.create_readwrite_async.begin (FileCreateFlags.PRIVATE, Priority.DEFAULT, null, (obj, res) => {;
		try {
			FileIOStream stream = file.create_readwrite_async.end (res);
			stream.output_stream.write ("My first line\n".data);
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
