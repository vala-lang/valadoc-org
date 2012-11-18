// Appends the current DateTime to "test.log"
static int main () {
	FileStream file = FileStream.open ("test.log", "a");
	assert (file != null);

	file.puts (new DateTime.now_local ().to_string ());
	file.putc ('\n');
	return 0;
}
