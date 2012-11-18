public static int main (string[] args) {
	// Output: ````
	for (int i = 0; i <= 255; i++) {
		char c = ((char) i);
		assert (c.ispunct () == (c.isgraph () && !c.isalnum ()));
	}

	// Output: ``,!``
	string str = "hello, world!";
	for (int i = 0; str[i] != '\0'; i++) {
		if (str[i].ispunct ()) {
			stdout.putc (str[i]);
		}
	}
	stdout.putc ('\n');
	return 0;
}
