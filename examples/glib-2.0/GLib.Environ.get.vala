public static int main (string[] args) {
	// Output:
	//  ``GJS_DEBUG_TOPICS=JS ERROR;JS LOG``
	//  ``G_BROKEN_FILENAMES=1``
	// ...
	string[] vars = Environ.get ();
	foreach (unowned string str in vars) {
		print ("%s\n", str);
	}
	return 0;
}
