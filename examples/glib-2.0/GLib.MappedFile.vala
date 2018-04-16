public static int main (string[] args) {
	try {
		MappedFile file = new MappedFile ("test.vala", false);
		print ((string) file.get_contents ());
		print ("Size: %" + size_t.FORMAT + " bytes\n", file.get_length ());
	} catch (FileError e) {
		print ("FileError: %s\n", e.message);
	}
	return 0;
}
