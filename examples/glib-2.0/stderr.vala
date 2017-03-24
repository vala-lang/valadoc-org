public int main (string[] args) {
	// Output:
	//  ``Formated error string``
	//  ``Simple error string``
	stderr.printf ("%s %s %s\n", "Formated", "error", "string");
	stderr.puts ("Simple error text");
	stderr.putc ('\n');
	return 0;
}
