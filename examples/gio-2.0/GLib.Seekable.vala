public static int main (string[] args) {
	File file = File.new_for_path ("my-test.txt");
	try {
		// Create a file that can only be accessed by the current user:
		FileIOStream ios = file.create_readwrite (FileCreateFlags.PRIVATE);

		// Write content to file:
		OutputStream os = ios.get_output_stream ();
		os.write ("My first line\n".data);
		os.write ("My second line\n".data);

		// Set the file pointer to the beginning of the stream:
		assert (ios.can_seek ());
		ios.seek (0, SeekType.SET);

		// Read content of file:
		InputStream @is = ios.input_stream;
		DataInputStream dis = new DataInputStream (@is);

		string line;
		while ((line = dis.read_line ()) != null) {
			print (line);
			print ("\n");
		}

	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
