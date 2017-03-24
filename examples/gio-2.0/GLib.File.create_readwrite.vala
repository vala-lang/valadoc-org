public static int main (string[] args) {
	// Create a file for reading and writing:
	File file = File.new_for_path ("my-test.txt");
	try {
		FileIOStream stream = file.create_readwrite (FileCreateFlags.PRIVATE);
		stream.output_stream.write ("My first line\n".data);
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}

	return 0;
}
