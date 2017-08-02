public static int main (string[] args) {
	// Output:
	//  ``my``
	//  ``splitted``
	//  ``string``
	string[] lines = Regex.split_simple ("[ \t]+", "my  splitted  \t string");
	foreach (string line in lines) {
		print ("%s\n", line);
	}
	return 0;
}
