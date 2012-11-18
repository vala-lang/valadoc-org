public static int main (string[] args) {
	File file = File.new_for_path ("my-test.txt");
	try {
		FileInputStream @is = file.read ();
		DataInputStream dis = new DataInputStream (@is);
		string line;

		while ((line = dis.read_line ()) != null) {
			stdout.printf ("%s\n", line);
		}
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
