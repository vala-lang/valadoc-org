static int main (string[] args) {
	FileStream stream = FileStream.open ("GLib.FileStream.ungetc.vala", "r");
	assert (stream != null);	

	while (stream.eof () == false) {
		// get first char of each line
		int c = stream.getc ();
		if (c == '#') {
			// ignore comments
			stream.read_line ();
		} else if (c >= 0) {
			stream.ungetc (c);
			stdout.puts (stream.read_line ());
			stdout.putc ('\n');
		}
	}

	return 0;
}
