public static int main (string[] args) {
	try {
		MappedFile file = new MappedFile ("test.vala", false);
		stdout.puts ((string) file.get_contents ());
		stdout.printf ("Size: %" + size_t.FORMAT + " bytes\n", file.get_length ());
	} catch (FileError e) {
		stdout.printf ("FileError: %s\n", e.message);
	}
	return 0;
}
