public static int main (string[] args) {
	string wisdom = "水は方円の器に従い、人は善悪の友による。";

	// Output: ``水は方円の器に従い、人は善悪の友による。``
	for (int i = 0; i < wisdom.length; i++) {
		if (wisdom.valid_char (i)) {
			stdout.puts (wisdom.get_char (i).to_string ());
		}
	}
	stdout.putc ('\n');
	return 0;
}
