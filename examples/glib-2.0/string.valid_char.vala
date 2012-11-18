public static int main (string[] args) {
	string wisdom = "水は方"; //円の器に従い、人は善悪の友による。

	// Output:
	//  ``true``	水
	//  ``false``
	//  ``false``
	//  ``true``	は
	//  ``false``
	//  ``false``
	//  ``true``	方
	//  ``false``
	//  ``false``
	for (int i = 0; i < wisdom.length; i++) {
		stdout.puts (wisdom.valid_char (i).to_string ());
		stdout.putc ('\n');
	}
	return 0;
}
