public static int main (string[] args) {
	// Output: ``azAZ09``
	stdout.puts ('a'.to_string ());
	stdout.puts ('z'.to_string ());
	stdout.puts ('A'.to_string ());
	stdout.puts ('Z'.to_string ());
	stdout.puts ('0'.to_string ());
	stdout.puts ('9'.to_string ());

	// Output: ````
	stdout.puts (((char) 0).to_string ());

	// Output: ``<newline>``
	stdout.puts ('\n'.to_string ());
	return 0;
}
