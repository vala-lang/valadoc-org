public static int main (string[] args) {
	MainLoop loop = new MainLoop ();

	File file = File.new_for_path ("my-test.txt");
	file.read_async.begin (Priority.DEFAULT, null, (obj, res) => {
		try {
			FileInputStream @is = file.read_async.end (res);
			DataInputStream dis = new DataInputStream (@is);
			string line;

			while ((line = dis.read_line ()) != null) {
				print ("%s\n", line);
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		loop.quit ();
	});

	loop.run ();
	return 0;
}
